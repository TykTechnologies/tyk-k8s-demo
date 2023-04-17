GRAFANA_SERVICE_PORT=9081;
grafanaReleaseName="prometheus-grafana";

if [ -z "$prometheusGrafanaRegistered" ]; then
  prometheusGrafanaRegistered=true;
  source "src/deployments/prometheus/main.safe.sh";
  source "src/deployments/prometheus-grafana/openshift.sh";
  source "src/deployments/prometheus-grafana/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
