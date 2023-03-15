logger "$INFO" "installing prometheus in $namespace namespace...";

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

addService "pump-svc-$tykReleaseName";
addDeploymentArgs "${args[@]}";

sed "s/replace_release_name/$tykReleaseName/g" src/deployments/prometheus/pump-svc.yaml | \
  sed "s/replace_pump_port/$PROMETHEUS_PUMP_PORT/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addService "$prometheusReleaseName-server";

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
