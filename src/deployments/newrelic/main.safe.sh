if [ -z "$newrelicRegistered" ]; then
  newrelicRegistered=true;

  newrelicReleaseName="newrelic";
  newrelicDeploymentPath="src/deployments/newrelic";

  source "$newrelicDeploymentPath/checks.sh";
  source "$newrelicDeploymentPath/main.sh";
fi
