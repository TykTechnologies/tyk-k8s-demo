if [ -z "$newrelicRegistered" ]; then
  newrelicRegistered=true;

  NEWRELIC_HEALTH_SERVICE_PORT=5556;
  newrelicReleaseName="newrelic";
  newrelicDeploymentPath="src/deployments/newrelic";

  source "$newrelicDeploymentPath/checks.sh";
  source "$newrelicDeploymentPath/main.sh";
fi
