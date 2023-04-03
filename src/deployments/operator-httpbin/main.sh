deploymentPath="src/deployments/operator-httpbin";

logger "$INFO" "creating Tyk Operator httpbin example...";

setVerbose;
kubectl apply -f "$deploymentPath/httpbin-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=httpbin --for condition=Ready --timeout=60s  > /dev/null;

# httpbin-keyless
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$deploymentPath/httpbin-keyless-api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

# httpbin-protected
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$deploymentPath/httpbin-protected-api-template.yaml" | \
  sed "s/api_namespace/$namespace/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
