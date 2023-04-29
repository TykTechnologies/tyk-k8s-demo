GRAFANA_SERVICE_PORT=9081;
grafanaReleaseName="prometheus-grafana";
prometheusGrafanaDeploymentPath="src/deployments/prometheus-grafana";

if [ -z "$prometheusGrafanaRegistered" ]; then
  prometheusGrafanaRegistered=true;
  source "src/deployments/prometheus/main.safe.sh";
  source "$prometheusGrafanaDeploymentPath/openshift.sh";
  source "$prometheusGrafanaDeploymentPath/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
