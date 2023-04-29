logger "$INFO" "creating Tyk Operator GraphQL Universal Data Graph examples...";

setVerbose;
# UDG DataSource - Users REST
addService "users-rest-svc";
kubectl apply --namespace "$namespace" -f "$operatorUDGDeploymentPath/users-rest-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=users-rest --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/users-rest-svc.$namespace.svc:3101/g" "$operatorUDGDeploymentPath/users-rest-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# UDG DataSource - Posts REST
addService "posts-rest-svc";
kubectl apply --namespace "$namespace" -f "$operatorUDGDeploymentPath/posts-rest-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=posts-rest --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/posts-rest-svc.$namespace.svc:3102/g" "$operatorUDGDeploymentPath/posts-rest-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# UDG DataSource - Comments REST
addService "comments-rest-svc";
kubectl apply --namespace "$namespace" -f "$operatorUDGDeploymentPath/comments-rest-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=comments-rest --for=condition=Ready --timeout=60s  > /dev/null;
sed "s/replace_service_url/comments-rest-svc.$namespace.svc:3103/g" "$operatorUDGDeploymentPath/comments-rest-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

usersID=$(kubectl get tykapis users-rest --namespace "$namespace" -o json | jq -r '.status.api_id');
postsID=$(kubectl get tykapis posts-rest --namespace "$namespace" -o json | jq -r '.status.api_id');
commentsID=$(kubectl get tykapis comments-rest --namespace "$namespace" -o json | jq -r '.status.api_id');

# UDG REST Stitch
sed "s/replace_users_url/$usersID/g" "$operatorUDGDeploymentPath/social-media-udg-rest-stitch-api-template.yaml" | \
  sed "s/replace_posts_url/$postsID/g" | \
  sed "s/replace_comments_url/$commentsID/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;
