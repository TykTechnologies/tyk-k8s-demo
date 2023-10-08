logger "$INFO" "creating Tyk Operator GraphQL examples...";

setVerbose;
# Vanilla Reverse Proxy
kubectl apply -f "$operatorGQLDeploymentPath/trevorblades-api.yaml" --namespace "$namespace" > /dev/null;

# Users Graph
addService "users-graph-svc";
kubectl apply --namespace "$namespace" -f "$operatorGQLDeploymentPath/users-graph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=users-graph --for=condition=Ready --timeout="$TYK_TIMEOUT" > /dev/null;

# Posts Graph
addService "posts-graph-svc";
kubectl apply --namespace "$namespace" -f "$operatorGQLDeploymentPath/posts-graph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=posts-graph --for=condition=Ready --timeout="$TYK_TIMEOUT" > /dev/null;

# Comments Graph
addService "comments-graph-svc";
kubectl apply --namespace "$namespace" -f "$operatorGQLDeploymentPath/comments-graph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=comments-graph --for=condition=Ready --timeout="$TYK_TIMEOUT" > /dev/null;

# Notifications Graph
addService "notifications-graph-svc";
kubectl apply --namespace "$namespace" -f "$operatorGQLDeploymentPath/notifications-graph-app.yaml" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=notifications-graph --for=condition=Ready --timeout="$TYK_TIMEOUT" > /dev/null;

unsetVerbose;
