operatorUDGDeploymentPath="src/deployments/operator-udg";

if [ -z "$operatorUDGRegistered" ]; then
  operatorUDGRegistered=true;
  source "src/deployments/operator-graphql/main.safe.sh";
  source "$operatorUDGDeploymentPath/main.sh";
fi
