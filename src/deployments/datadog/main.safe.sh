DATADOG_SERVICE_PORT=8125;
DATADOG_AGENT_HEALTH_SERVICE_PORT=5555;
datadogReleaseName="datadog";
datadogDeploymentPath="src/deployments/datadog";

if [ -z "$datadogRegistered" ]; then
  datadogRegistered=true;
  source "$datadogDeploymentPath/checks.sh";
  source "$datadogDeploymentPath/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
