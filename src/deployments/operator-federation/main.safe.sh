operatorFederationDeploymentPath="src/deployments/operator-federation";

if [ -z "$operatorFederationRegistered" ]; then
  operatorFederationRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "$operatorFederationDeploymentPath/main.sh";
fi
