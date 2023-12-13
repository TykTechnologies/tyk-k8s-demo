if [ -z "$operatorUDGRegistered" ]; then
  operatorUDGRegistered=true;

  operatorUDGDeploymentPath="src/deployments/operator-udg";

  source "src/deployments/operator-graphql/main.safe.sh";
  source "$operatorUDGDeploymentPath/main.sh";
fi
