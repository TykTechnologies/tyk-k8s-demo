PROMETHEUS_PUMP_PORT=9091;
PROMETHEUS_SERVICE_PORT=9080;
PROMETHEUS_PUMP_PATH="/metrics";
prometheusReleaseName="prometheus";

if [ -z "$prometheusRegistered" ]; then
  prometheusRegistered=true;
  source "src/deployments/prometheus/main.sh";
fi
