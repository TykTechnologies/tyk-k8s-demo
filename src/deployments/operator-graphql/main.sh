logger "$INFO" "creating Tyk Operator GraphQL examples...";

setVerbose;
# Vanilla Reverse Proxy
kubectl apply -f "$operatorGQLDeploymentPath/trevorblades-api.yaml" --namespace "$namespace" > /dev/null;
unsetVerbose;
