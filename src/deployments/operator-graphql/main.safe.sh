if [ -z "$operatorGQLRegistered" ]; then
  operatorGQLRegistered=true;

  operatorGQLDeploymentPath="src/deployments/operator-graphql";

  source "src/deployments/operator/main.safe.sh";
  source "$operatorGQLDeploymentPath/main.sh";
fi
