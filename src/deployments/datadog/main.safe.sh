DATADOG_SERVICE_PORT=8125;
datadogReleaseName="datadog";
datadogDeploymentPath="src/deployments/datadog";

if [ -z "$datadogRegistered" ]; then
  datadogRegistered=true;
  source "$datadogDeploymentPath/checks.sh";
  source "$datadogDeploymentPath/openshift.sh";
  source "$datadogDeploymentPath/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
