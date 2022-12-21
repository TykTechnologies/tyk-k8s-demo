logger "$INFO" "Creating Tyk Operator httpbin example...";

setVerbose;
kubectl apply -f src/deployments/operator-httpbin/httpbin-svc.yaml -n "$namespace";

# httpbin key-less
sed "s/service_url/httpbin-svc.$namespace.svc:8000/g" src/deployments/operator-httpbin/httpbin-keyless-api.yaml | \
  kubectl apply -n "$namespace" -f -;

# httpbin ingress
# TODO

unsetVerbose;

