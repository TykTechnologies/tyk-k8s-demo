if [ -z "$operatorGQLRegistered" ]; then
  operatorGQLRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "src/deployments/operator-graphql/main.sh";
fi
