deploymentPath="src/deployments/operator-graphql";
udgPath="$deploymentPath/udg-rest";
fedPath="$deploymentPath/federation";

if ! $operatorGQLRegistered; then
  operatorGQLRegistered=true;
  source "src/deployments/operator-graphql/main.sh";
fi

addService "users-rest-svc";
addService "posts-rest-svc";
addService "comments-rest-svc";
addService "users-subgraph-svc";
addService "posts-subgraph-svc";
addService "comments-subgraph-svc";
addService "notifications-subgraph-svc";
