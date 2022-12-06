PROMETHEUS_PUMP_PORT=9091;
PROMETHEUS_SERVICE_PORT=9080;
PROMETHEUS_PUMP_PATH="/metrics";

args=(--set "pump.extraEnvs[$pumpCtr].name=TYK_PMP_PUMPS_PROMETHEUS_TYPE" \
  --set "pump.extraEnvs[$pumpCtr].value=prometheus" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].name=TYK_PMP_PUMPS_PROMETHEUS_META_ADDR" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].value=0.0.0.0:$PROMETHEUS_PUMP_PORT" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].name=TYK_PMP_PUMPS_PROMETHEUS_META_PATH" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].value=$PROMETHEUS_PUMP_PATH" \
  --set "pump.extraEnvs[$(($pumpCtr + 3))].name=TYK_PMP_PUMPS_PROMETHEUS_META_CUSTOMMETRICS" \
  --set "pump.extraEnvs[$(($pumpCtr + 3))].value='[{\"name\":\"tyk_http_requests_total\",\"description\":\"Total of API requests\",\"metric_type\":\"counter\",\"labels\":[\"response_code\",\"api_name\",\"method\",\"api_key\",\"alias\",\"path\"]},{\"name\":\"tyk_http_latency\",\"description\":\"Latency of API requests\",\"metric_type\":\"histogram\",\"labels\":[\"type\",\"response_code\",\"api_name\",\"method\",\"api_key\",\"alias\",\"path\"]}]'");
pumpCtr=$((pumpCtr + 4));

addService "pump-svc-$tykReleaseName";
addDeploymentArgs "${args[@]}";

helm upgrade $tykReleaseName $TYK_HELM_CHART_PATH/$chart \
  -n $namespace \
  "${deploymentsArgs[@]}" \
  --atomic \
  --wait > /dev/null

tmp=$(mktemp)
kubectl create service nodeport pump-svc-$tykReleaseName --tcp=$PROMETHEUS_PUMP_PORT:$PROMETHEUS_PUMP_PORT -o yaml --dry-run=client | kubectl set selector --local -f - "app=pump-$tykReleaseName" -o yaml > "$tmp";
kubectl apply -f "$tmp" -n $namespace;

logger $INFO "Add Prometheus helm repo...";
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts > /dev/null;
helm repo update > /dev/null;

prometheusReleaseName="tyk-prometheus";
checkHelmReleaseExists $prometheusReleaseName;

addService "tyk-prometheus-server";

command="upgrade";
if ! $releaseExists; then
  command="install";
fi

helm $command $prometheusReleaseName prometheus-community/prometheus \
  --set "server.service.servicePort=$PROMETHEUS_SERVICE_PORT" \
  --set "serverFiles.prometheus\.yml.scrape_configs[0].job_name=tyk" \
  --set "serverFiles.prometheus\.yml.scrape_configs[0].metrics_path=$PROMETHEUS_PUMP_PATH" \
  --set "serverFiles.prometheus\.yml.scrape_configs[0].static_configs[0].targets={pump-svc-$tykReleaseName.$namespace.svc:$PROMETHEUS_PUMP_PORT}" \
  -n $namespace > /dev/null;
