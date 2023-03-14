deploymentPath="src/deployments/operator-httpbin";

logger "$INFO" "creating Tyk Operator httpbin example...";

setVerbose;
addService "httpbin-svc";
kubectl apply -f "$deploymentPath/httpbin-svc.yaml" --namespace "$namespace" > /dev/null;
kubectl wait pods --namespace "$namespace" -l app=httpbin --for condition=Ready --timeout=60s  > /dev/null;

# httpbin-keyless
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$deploymentPath/httpbin-keyless-api.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# httpbin-protected
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$deploymentPath/httpbin-protected-api.yaml" | \
  sed "s/api_namespace/$namespace/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# httpbin-jwt
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$deploymentPath/httpbin-jwt-api.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# httpbin ingress
# TODO

unsetVerbose;
