if [ -z "$operatorFederationRegistered" ]; then
  operatorFederationRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "src/deployments/operator-federation/main.sh";
fi
