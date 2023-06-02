logger "$INFO" "creating Tyk Operator httpbin example...";

addService "httpbin-svc";

setVerbose;
kubectl apply -f "$operatorHTTPDeploymentPath/httpbin-svc.yaml" -n "$namespace" > /dev/null;
kubectl wait pods -n "$namespace" -l app=httpbin --for condition=Ready --timeout=60s  > /dev/null;

# httpbin-keyless
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$operatorHTTPDeploymentPath/api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
