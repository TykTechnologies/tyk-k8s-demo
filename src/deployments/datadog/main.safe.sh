DATADOG_SERVICE_PORT=8125;
datadogReleaseName="datadog";

if [ -z "$datadogRegistered" ]; then
  datadogRegistered=true;
  source "src/deployments/datadog/checks.sh";
  source "src/deployments/datadog/openshift.sh";
  source "src/deployments/datadog/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
