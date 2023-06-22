customMetrics="[{\"name\": \"tyk_http_requests_total\"\,\"description\": \"Total of API requests\"\,\"metric_type\": \"counter\"\,\"labels\": [\"response_code\"\,\"api_name\"\,\"method\"\,\"api_key\"\,\"alias\"\,\"path\"]}\,{\"name\": \"tyk_http_latency\"\,\"description\": \"Latency of API requests\"\,\"metric_type\": \"histogram\"\,\"labels\": [\"type\"\,\"response_code\"\,\"api_name\"\,\"method\"\,\"api_key\"\,\"alias\"\,\"path\"]}]"

args=(--set "tyk-pump.pump.backend[$pumpBackendsCtr]=prometheus" \
  --set "tyk-pump.pump.prometheusPump.host=0.0.0.0:" \
  --set "tyk-pump.pump.prometheusPump.path=$PROMETHEUS_PUMP_PATH" \
  --set "tyk-pump.pump.prometheusPump.port=$PROMETHEUS_PUMP_PORT" \
  --set "tyk-pump.pump.prometheusPump.customMetrics=$customMetrics");

addService "pump-svc-$tykReleaseName-$chart";
addDeploymentArgs "${args[@]}";
upgradeTyk;

pumpBackendsCtr=$((pumpBackendsCtr + 1));
sed "s/replace_release_name/$tykReleaseName-$chart/g" "$prometheusDeploymentPath/pump-svc.yaml" | \
  sed "s/replace_pump_port/$PROMETHEUS_PUMP_PORT/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
