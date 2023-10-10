if [ -z "$operatorRegistered" ]; then
  operatorRegistered=true;

  operatorReleaseName="tyk-operator";
  operatorDeploymentPath="src/deployments/operator";

  source "src/deployments/cert-manager/main.safe.sh";
  source "$operatorDeploymentPath/ssl.sh";
  source "$operatorDeploymentPath/checks.sh";
  source "$operatorDeploymentPath/openshift.sh";
  source "$operatorDeploymentPath/main.sh";
fi
