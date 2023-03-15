logger "$INFO" "creating Tyk Operator GraphQL examples...";

setVerbose;
# Vanilla Reverse Proxy
kubectl apply -f "src/deployments/operator-graphql/trevorblades-api.yaml" --namespace "$namespace" > /dev/null;
unsetVerbose;
