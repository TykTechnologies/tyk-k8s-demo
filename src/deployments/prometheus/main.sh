PROMETHEUS_PUMP_PORT=9091;
PROMETHEUS_SERVICE_PORT=9080;
GRAFANA_SERVICE_PORT=9081;
PROMETHEUS_PUMP_PATH="/metrics";

customMetrics="[{\"name\": \"tyk_http_requests_total\"\,\"description\": \"Total of API requests\"\,\"metric_type\": \"counter\"\,\"labels\": [\"response_code\"\,\"api_name\"\,\"method\"\,\"api_key\"\,\"alias\"\,\"path\"]}\,{\"name\": \"tyk_http_latency\"\,\"description\": \"Latency of API requests\"\,\"metric_type\": \"histogram\"\,\"labels\": [\"type\"\,\"response_code\"\,\"api_name\"\,\"method\"\,\"api_key\"\,\"alias\"\,\"path\"]}]"

args=(--set "pump.extraEnvs[$pumpCtr].name=TYK_PMP_PUMPS_PROMETHEUS_TYPE" \
  --set "pump.extraEnvs[$pumpCtr].value=prometheus" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].name=TYK_PMP_PUMPS_PROMETHEUS_META_ADDR" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].value=0.0.0.0:$PROMETHEUS_PUMP_PORT" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].name=TYK_PMP_PUMPS_PROMETHEUS_META_PATH" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].value=$PROMETHEUS_PUMP_PATH" \
  --set "pump.extraEnvs[$(($pumpCtr + 3))].name=TYK_PMP_PUMPS_PROMETHEUS_META_CUSTOMMETRICS" \
  --set "pump.extraEnvs[$(($pumpCtr + 3))].value=$customMetrics");
pumpCtr=$((pumpCtr + 4));

addDeploymentArgs "${args[@]}";

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --atomic \
  --wait > /dev/null
unsetVerbose;

sed "s/replace_release_name/$tykReleaseName/g" src/deployments/prometheus/pump-svc.yaml | \
  sed "s/replace_pump_port/$PROMETHEUS_PUMP_PORT/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

setVerbose;
helm upgrade $prometheusReleaseName prometheus-community/prometheus \
  --install \
  --set "server.service.servicePort=$PROMETHEUS_SERVICE_PORT" \
  --set "server.global.scrape_interval=15s" \
  --set "server.global.evaluation_interval=15s" \
  --set "serverFiles.recording_rules\.yml.groups[0].name=tyk" \
  --set "serverFiles.recording_rules\.yml.groups[0].rules[0].record=task:http_response_error_count" \
  --set "serverFiles.recording_rules\.yml.groups[0].rules[0].expr=tyk_http_requests_total{response_code=~\"5\[0-9]{2}\"}" \
  --set "serverFiles.recording_rules\.yml.groups[0].rules[1].record=task:http_response_total_count" \
  --set "serverFiles.recording_rules\.yml.groups[0].rules[1].expr=tyk_http_requests_total{response_code=~\"\[0-9]{3}\"}" \
  --set "serverFiles.recording_rules\.yml.groups[0].rules[2].record=task:http_response_error_rate" \
  --set "serverFiles.recording_rules\.yml.groups[0].rules[2].expr=sum by (job\,api_name) (rate(task:http_response_error_count\[1m]))" \
  --set "serverFiles.recording_rules\.yml.groups[1].name=slo_metrics" \
  --set "serverFiles.recording_rules\.yml.groups[1].rules[0].record=job:slo_errors_per_request:ratio_rate10m" \
  --set "serverFiles.recording_rules\.yml.groups[1].rules[0].expr=sum by (job\,api_name) (rate(task:http_response_error_count\[10m])) / sum by (job\,api_name) (rate(task:http_response_total_count\[10m]))" \
  --set "serverFiles.recording_rules\.yml.groups[1].rules[1].record=job:error_budget:remaining" \
  --set "serverFiles.recording_rules\.yml.groups[1].rules[1].expr=(1 - job:slo_errors_per_request:ratio_rate10m) * 100" \
  --set "serverFiles.prometheus\.yml.scrape_configs[0].job_name=tyk" \
  --set "serverFiles.prometheus\.yml.scrape_configs[0].metrics_path=$PROMETHEUS_PUMP_PATH" \
  --set "serverFiles.prometheus\.yml.scrape_configs[0].static_configs[0].targets={pump-svc-$tykReleaseName.$namespace.svc:$PROMETHEUS_PUMP_PORT}" \
  --namespace "$namespace" > /dev/null;
unsetVerbose;

setVerbose;
kubectl apply -f src/deployments/prometheus/grafana-dashboards-configmap.yaml --namespace "$namespace" > /dev/null;
helm upgrade $grafanaReleaseName grafana/grafana \
  --install \
  --set "adminPassword=$PASSWORD" \
  --set "service.port=$GRAFANA_SERVICE_PORT" \
  --set "datasources.datasources\.yaml.apiVersion=1" \
  --set "datasources.datasources\.yaml.datasources[0].name=Prometheus" \
  --set "datasources.datasources\.yaml.datasources[0].type=prometheus" \
  --set "datasources.datasources\.yaml.datasources[0].url=http://$prometheusReleaseName-server:$PROMETHEUS_SERVICE_PORT" \
  --set "datasources.datasources\.yaml.datasources[0].access=proxy" \
  --set "datasources.datasources\.yaml.datasources[0].isDefault=true" \
  --set "dashboardProviders.dashboardproviders\.yaml.apiVersion=1" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].name=Tyk" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].orgId=1" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].type=file" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].disableDeletion=false" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].editable=true" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].updateIntervalSeconds=10" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].options.path=/etc/tyk-grafana/provisioning/dashboards" \
  --set "extraConfigmapMounts[0].name=grafana-dashboards" \
  --set "extraConfigmapMounts[0].mountPath=/etc/tyk-grafana/provisioning/dashboards/dashboards.json" \
  --set "extraConfigmapMounts[0].subPath=dashboards.json" \
  --set "extraConfigmapMounts[0].configMap=grafana-dashboards-configmap" \
  --set "extraConfigmapMounts[0].readOnly=true" \
  --namespace "$namespace" > /dev/null;
unsetVerbose;

addSummary "\n\
\tGrafana deployed\n \
\tUsername: admin\n \
\tPassword: $(kubectl get secret --namespace "$namespace" "$grafanaReleaseName" -o jsonpath="{.data.admin-password}" | base64 --decode)\n";
