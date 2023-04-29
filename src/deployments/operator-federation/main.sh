logger "$INFO" "creating Tyk Operator GraphQL Federation examples...";

setVerbose;
# Federation - Users Subgraph
addService "users-subgraph-svc";
kubectl apply --namespace "$namespace" -f "$selfSignedCertsDeploymentPath/users-subgraph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=users-subgraph --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/users-subgraph-svc.$namespace.svc:4201/g" "$selfSignedCertsDeploymentPath/users-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# Federation - Posts Subgraph
addService "posts-subgraph-svc";
kubectl apply --namespace "$namespace" -f "$selfSignedCertsDeploymentPath/posts-subgraph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=posts-subgraph --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/posts-subgraph-svc.$namespace.svc:4202/g" "$selfSignedCertsDeploymentPath/posts-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# Federation - Comments Subgraph
addService "comments-subgraph-svc";
kubectl apply --namespace "$namespace" -f "$selfSignedCertsDeploymentPath/comments-subgraph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=comments-subgraph --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/comments-subgraph-svc.$namespace.svc:4203/g" "$selfSignedCertsDeploymentPath/comments-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# Federation - Notifications Subgraph
addService "notifications-subgraph-svc";
kubectl apply --namespace "$namespace" -f "$selfSignedCertsDeploymentPath/notifications-subgraph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=notifications-subgraph --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/notifications-subgraph-svc.$namespace.svc:4204/g" "$selfSignedCertsDeploymentPath/notifications-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

kubectl apply --namespace "$namespace" -f "$selfSignedCertsDeploymentPath/social-media-federation-api.yaml" > /dev/null;
unsetVerbose;
