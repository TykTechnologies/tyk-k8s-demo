if [ -z "$mosquittoRegistered" ]; then
  mosquittoRegistered=true;

  MOSQUITTO_SERVICE_PORT=1883;

  mosquittoReleaseName="tyk-mosquitto";
  mosquittoDeploymentPath="src/deployments/mosquitto";

  source "$mosquittoDeploymentPath/checks.sh";
  source "$mosquittoDeploymentPath/main.sh";
fi
