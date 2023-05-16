operatorJWTHMACDeploymentPath="src/deployments/operator-jwt-hmac";

if [ -z "$operatorJWTHMACRegistered" ]; then
  operatorJWTHMACRegistered=true;
  secret="topsecretpassword";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorJWTHMACDeploymentPath/main.sh";
fi
