if [ -z "$operatorJWTHMACRegistered" ]; then
  operatorJWTHMACRegistered=true;

  operatorJWTHMACDeploymentPath="src/deployments/operator-jwt-hmac";

  secret="topsecretpassword";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorJWTHMACDeploymentPath/main.sh";
fi
