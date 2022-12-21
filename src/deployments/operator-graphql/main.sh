logger "$INFO" "creating Tyk Operator GraphQL examples...";

setVerbose;
# Vanilla Reverse Proxy
kubectl apply -f src/deployments/operator-graphql/trevorblades-api.yaml -n "$namespace";

# UDG DataSource - Users REST
addService "users-rest-svc";
kubectl apply -f src/deployments/operator-graphql/udg-rest/users-rest-svc.yaml -n "$namespace";
sed "s/service_url/users-rest-svc.$namespace.svc:3101/g" src/deployments/operator-graphql/udg-rest/users-rest-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# UDG DataSource - Posts REST
addService "posts-rest-svc";
kubectl apply -f src/deployments/operator-graphql/udg-rest/posts-rest-svc.yaml -n "$namespace";
sed "s/service_url/posts-rest-svc.$namespace.svc:3102/g" src/deployments/operator-graphql/udg-rest/posts-rest-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# UDG DataSource - Comments REST
addService "comments-rest-svc";
kubectl apply -f src/deployments/operator-graphql/udg-rest/comments-rest-svc.yaml -n "$namespace";
sed "s/service_url/comments-rest-svc.$namespace.svc:3103/g" src/deployments/operator-graphql/udg-rest/comments-rest-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# Federation - Users Subgraph
addService "users-subgraph-svc";
kubectl apply -f src/deployments/operator-graphql/federation/users-subgraph-svc.yaml -n "$namespace";
sed "s/service_url/users-subgraph-svc.$namespace.svc:4201/g" src/deployments/operator-graphql/federation/users-subgraph-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# Federation - Posts Subgraph
addService "posts-subgraph-svc";
kubectl apply -f src/deployments/operator-graphql/federation/posts-subgraph-svc.yaml -n "$namespace";
sed "s/service_url/posts-subgraph-svc.$namespace.svc:4202/g" src/deployments/operator-graphql/federation/posts-subgraph-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# Federation - Comments Subgraph
addService "comments-subgraph-svc";
kubectl apply -f src/deployments/operator-graphql/federation/comments-subgraph-svc.yaml -n "$namespace";
sed "s/service_url/comments-subgraph-svc.$namespace.svc:4203/g" src/deployments/operator-graphql/federation/comments-subgraph-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# Federation - Notifications Subgraph
addService "notifications-subgraph-svc";
kubectl apply -f src/deployments/operator-graphql/federation/notifications-subgraph-svc.yaml -n "$namespace";
sed "s/service_url/notifications-subgraph-svc.$namespace.svc:4204/g" src/deployments/operator-graphql/federation/notifications-subgraph-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# UDG REST Stitch
sed "s/users-rest/$(kubectl get tykapis users-rest -n "$namespace" -o json | jq -r '.status.api_id')/g" src/deployments/operator-graphql/social-media-udg-rest-stitch-api.yaml | \
  sed "s/posts-rest/$(kubectl get tykapis posts-rest -n "$namespace" -o json | jq -r '.status.api_id')/g" | \
  sed "s/comments-rest/$(kubectl get tykapis comments-rest -n "$namespace" -o json | jq -r '.status.api_id')/g" | \
  kubectl apply -n "$namespace" -f -;

kubectl apply -n "$namespace" -f src/deployments/operator-graphql/social-media-federation-api.yaml;

unsetVerbose;


