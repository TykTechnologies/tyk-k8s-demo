operatorUDGDeploymentPath="src/deployments/operator-udg";

if [ -z "$operatorUDGRegistered" ]; then
  operatorUDGRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "$operatorUDGDeploymentPath/main.sh";
fi
