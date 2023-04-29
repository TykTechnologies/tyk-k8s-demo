operatorReleaseName="tyk-operator";
certManagerReleaseName="tyk-operator-cert-manager";
operatorDeploymentPath="src/deployments/operator";

if [ -z "$operatorRegistered" ]; then
  operatorRegistered=true;
  source "$operatorDeploymentPath/checks.sh";
  source "$operatorDeploymentPath/openshift.sh";
  source "$operatorDeploymentPath/main.sh";
fi
