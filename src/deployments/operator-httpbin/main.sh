deploymentPath="src/deployments/operator-httpbin";

logger "$INFO" "creating Tyk Operator httpbin example...";

setVerbose;
#addService "httpbin-svc";
#sed "s/replace_run_as_user/$applicationSecurityContextUID/g" "$deploymentPath/httpbin-svc-template.yaml" | \
#  sed "s/replace_run_as_group/$applicationSecurityContextUID/g" | \
#  kubectl apply --namespace "$namespace" -f - > /dev/null;
#kubectl wait pods --namespace "$namespace" -l app=httpbin --for=condition=Ready --timeout=60s  > /dev/null;

# httpbin-keyless
sed "s/replace_service_url/httpbin.org/g" "$deploymentPath/httpbin-keyless-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# httpbin-protected
sed "s/replace_service_url/httpbin.org/g" "$deploymentPath/httpbin-protected-api-template.yaml" | \
  sed "s/api_namespace/$namespace/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# httpbin-jwt
sed "s/replace_service_url/httpbin.org/g" "$deploymentPath/httpbin-jwt-api-template.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;
