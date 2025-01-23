if [ -z "$nodeRedRegistered" ]; then
  nodeRedRegistered=true;

  NODERED_SERVICE_PORT=1880;

  nodeRedReleaseName="tyk-node-red";
  nodeRedDeploymentPath="src/deployments/node-red";

  source "$nodeRedDeploymentPath/checks.sh";
  source "$nodeRedDeploymentPath/main.sh";
fi
