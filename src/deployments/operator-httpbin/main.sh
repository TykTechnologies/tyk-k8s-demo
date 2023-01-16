logger "$INFO" "creating Tyk Operator httpbin example...";

setVerbose;
kubectl apply -f src/deployments/operator-httpbin/httpbin-svc.yaml -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=httpbin --for condition=Ready --timeout=60s  > /dev/null;

# httpbin key-less
sed "s/service_url/httpbin-svc.$namespace.svc:8000/g" src/deployments/operator-httpbin/httpbin-keyless-api.yaml | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# httpbin ingress
# TODO

unsetVerbose;
