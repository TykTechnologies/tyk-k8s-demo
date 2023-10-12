if [ -z "$operatorFederationRegistered" ]; then
  operatorFederationRegistered=true;

  operatorFederationDeploymentPath="src/deployments/operator-federation";

  source "src/deployments/operator/main.safe.sh";
  source "$operatorFederationDeploymentPath/main.sh";
fi
