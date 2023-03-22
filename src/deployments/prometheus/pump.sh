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

addService "pump-svc-$tykReleaseName-$chart";
addDeploymentArgs "${args[@]}";

sed "s/replace_release_name/$tykReleaseName/g" src/deployments/prometheus/pump-svc.yaml | \
  sed "s/replace_pump_port/$PROMETHEUS_PUMP_PORT/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null
unsetVerbose;
