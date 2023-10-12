if [ -z "$prometheusGrafanaRegistered" ]; then
  prometheusGrafanaRegistered=true;

  GRAFANA_SERVICE_PORT=9081;
  grafanaReleaseName="prometheus-grafana";
  prometheusGrafanaDeploymentPath="src/deployments/prometheus-grafana";

  source "src/deployments/prometheus/main.safe.sh";
  source "$prometheusGrafanaDeploymentPath/openshift.sh";
  source "$prometheusGrafanaDeploymentPath/load-balancer.sh";
  source "$prometheusGrafanaDeploymentPath/ingress.sh";
  source "$prometheusGrafanaDeploymentPath/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
