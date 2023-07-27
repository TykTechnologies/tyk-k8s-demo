operatorReleaseName="tyk-operator";
operatorDeploymentPath="src/deployments/operator";

if [ -z "$operatorRegistered" ]; then
  operatorRegistered=true;
  source "src/deployments/cert-manager/main.safe.sh";
  source "$operatorDeploymentPath/checks.sh";
  source "$operatorDeploymentPath/openshift.sh";
  source "$operatorDeploymentPath/main.sh";
fi
