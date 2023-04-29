operatorGQLDeploymentPath="src/deployments/operator-graphql";

if [ -z "$operatorGQLRegistered" ]; then
  operatorGQLRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "$operatorGQLDeploymentPath/main.sh";
fi
