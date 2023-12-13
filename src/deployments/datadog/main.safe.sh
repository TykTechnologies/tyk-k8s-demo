if [ -z "$datadogRegistered" ]; then
  datadogRegistered=true;

  DATADOG_SERVICE_PORT=8125;
  DATADOG_AGENT_HEALTH_SERVICE_PORT=5555;
  datadogReleaseName="datadog";
  datadogDeploymentPath="src/deployments/datadog";

  source "$datadogDeploymentPath/checks.sh";
  source "$datadogDeploymentPath/main.sh";
fi
