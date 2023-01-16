logger "$INFO" "creating Tyk Operator GraphQL examples...";

deploymentPath="src/deployments/operator-graphql";
udgPath="$deploymentPath/udg-rest";
fedPath="$deploymentPath/federation";

setVerbose;
# Vanilla Reverse Proxy
kubectl apply -f "$deploymentPath/trevorblades-api.yaml" -n "$namespace" > /dev/null;

# UDG DataSource - Users REST
addService "users-rest-svc";
kubectl apply -f "$udgPath/users-rest-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=users-rest --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/users-rest-svc.$namespace.svc:3101/g" "$udgPath/users-rest-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# UDG DataSource - Posts REST
addService "posts-rest-svc";
kubectl apply -f "$udgPath/posts-rest-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=posts-rest --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/posts-rest-svc.$namespace.svc:3102/g" "$udgPath/posts-rest-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# UDG DataSource - Comments REST
addService "comments-rest-svc";
kubectl apply -f "$udgPath/comments-rest-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=comments-rest --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/comments-rest-svc.$namespace.svc:3103/g" "$udgPath/comments-rest-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# Federation - Users Subgraph
addService "users-subgraph-svc";
kubectl apply -f "$fedPath/users-subgraph-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=users-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/users-subgraph-svc.$namespace.svc:4201/g" "$fedPath/users-subgraph-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# Federation - Posts Subgraph
addService "posts-subgraph-svc";
kubectl apply -f "$fedPath/posts-subgraph-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=posts-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/posts-subgraph-svc.$namespace.svc:4202/g" "$fedPath/posts-subgraph-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# Federation - Comments Subgraph
addService "comments-subgraph-svc";
kubectl apply -f "$fedPath/comments-subgraph-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=comments-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/comments-subgraph-svc.$namespace.svc:4203/g" "$fedPath/comments-subgraph-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# Federation - Notifications Subgraph
addService "notifications-subgraph-svc";
kubectl apply -f "$fedPath/notifications-subgraph-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=notifications-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/service_url/notifications-subgraph-svc.$namespace.svc:4204/g" "$fedPath/notifications-subgraph-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

usersID=$(kubectl get tykapis users-rest -n "$namespace" -o json | jq -r '.status.api_id');
postsID=$(kubectl get tykapis posts-rest -n "$namespace" -o json | jq -r '.status.api_id');
commentsID=$(kubectl get tykapis comments-rest -n "$namespace" -o json | jq -r '.status.api_id');

# UDG REST Stitch
sed "s/users-rest/$usersID/g" "$deploymentPath/social-media-udg-rest-stitch-api-template.yaml" | \
  sed "s/posts-rest/$postsID/g" | \
  sed "s/comments-rest/$commentsID/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

kubectl apply -n "$namespace" -f "$deploymentPath/social-media-federation-api-template.yaml" > /dev/null;

unsetVerbose;
