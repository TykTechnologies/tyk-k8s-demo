logger "$INFO" "creating Tyk Operator GraphQL Federation examples...";

deploymentPath="src/deployments/operator-federation";

setVerbose;
# Federation - Users Subgraph
addService "users-subgraph-svc";
sed "s/replace_runAsUser/$applicationSecurityContextUID/g" "$deploymentPath/users-subgraph-app-template.yaml" | \
  sed "s/replace_runAsGroup/$applicationSecurityContextUID/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=users-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/users-subgraph-svc.$namespace.svc:4201/g" "$deploymentPath/users-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# Federation - Posts Subgraph
addService "posts-subgraph-svc";
sed "s/replace_runAsUser/$applicationSecurityContextUID/g" "$deploymentPath/posts-subgraph-app-template.yaml" | \
  sed "s/replace_runAsGroup/$applicationSecurityContextUID/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=posts-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/posts-subgraph-svc.$namespace.svc:4202/g" "$deploymentPath/posts-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# Federation - Comments Subgraph
addService "comments-subgraph-svc";
sed "s/replace_runAsUser/$applicationSecurityContextUID/g" "$deploymentPath/comments-subgraph-app-template.yaml" | \
  sed "s/replace_runAsGroup/$applicationSecurityContextUID/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=comments-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/comments-subgraph-svc.$namespace.svc:4203/g" "$deploymentPath/comments-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# Federation - Notifications Subgraph
addService "notifications-subgraph-svc";
sed "s/replace_runAsUser/$applicationSecurityContextUID/g" "$deploymentPath/notifications-subgraph-app-template.yaml" | \
  sed "s/replace_runAsGroup/$applicationSecurityContextUID/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=notifications-subgraph --for condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/notifications-subgraph-svc.$namespace.svc:4204/g" "$deploymentPath/notifications-subgraph-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

kubectl apply --namespace "$namespace" -f "$deploymentPath/social-media-federation-api.yaml" > /dev/null;
unsetVerbose;
