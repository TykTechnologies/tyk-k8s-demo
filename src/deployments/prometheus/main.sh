logger "$INFO" "installing $prometheusReleaseName in $namespace namespace...";

addService "$prometheusReleaseName-server";

setVerbose;
helm upgrade "$prometheusReleaseName" prometheus-community/prometheus \
  --install \
  --version 20.0.1 \
  --set "server.service.servicePort=$PROMETHEUS_SERVICE_PORT" \
  --set "server.global.scrape_interval=15s" \
  --set "server.global.evaluation_interval=15s" \
  "${prometheusSecurityContextArgs[@]}" \
  --namespace "$namespace" > /dev/null;
unsetVerbose;

source src/deployments/prometheus/pump.sh;

#  --set "serverFiles.recording_rules\.yml.groups[0].name=tyk" \
#  --set "serverFiles.recording_rules\.yml.groups[0].rules[0].record=task:http_response_error_count" \
#  --set "serverFiles.recording_rules\.yml.groups[0].rules[0].expr=tyk_http_requests_total{response_code=~\"5\[0-9]{2}\"}" \
#  --set "serverFiles.recording_rules\.yml.groups[0].rules[1].record=task:http_response_total_count" \
#  --set "serverFiles.recording_rules\.yml.groups[0].rules[1].expr=tyk_http_requests_total{response_code=~\"\[0-9]{3}\"}" \
#  --set "serverFiles.recording_rules\.yml.groups[0].rules[2].record=task:http_response_error_rate" \
#  --set "serverFiles.recording_rules\.yml.groups[0].rules[2].expr=sum by (job\,api_name) (rate(task:http_response_error_count\[1m]))" \
#  --set "serverFiles.recording_rules\.yml.groups[1].name=slo_metrics" \
#  --set "serverFiles.recording_rules\.yml.groups[1].rules[0].record=job:slo_errors_per_request:ratio_rate10m" \
#  --set "serverFiles.recording_rules\.yml.groups[1].rules[0].expr=sum by (job\,api_name) (rate(task:http_response_error_count\[10m])) / sum by (job\,api_name) (rate(task:http_response_total_count\[10m]))" \
#  --set "serverFiles.recording_rules\.yml.groups[1].rules[1].record=job:error_budget:remaining" \
#  --set "serverFiles.recording_rules\.yml.groups[1].rules[1].expr=(1 - job:slo_errors_per_request:ratio_rate10m) * 100" \
#  --set "serverFiles.prometheus\.yml.scrape_configs[0].job_name=tyk" \
#  --set "serverFiles.prometheus\.yml.scrape_configs[0].metrics_path=$PROMETHEUS_PUMP_PATH" \
#  --set "serverFiles.prometheus\.yml.scrape_configs[0].static_configs[0].targets={pump-svc-$tykReleaseName-$chart.$namespace.svc:$PROMETHEUS_PUMP_PORT}" \
