deploymentPath="src/deployments/operator-httpbin";

logger "$INFO" "creating Tyk Operator httpbin example...";

setVerbose;
# httpbin-keyless
kubectl apply --namespace "$namespace" -f "$deploymentPath/httpbin-keyless-api-template.yaml" > /dev/null;

# httpbin-protected
sed "s/replace_namespace/$namespace/g" "$deploymentPath/httpbin-protected-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

# httpbin-jwt
sed "s/replace_namespace/$namespace/g" "$deploymentPath/httpbin-jwt-api-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;
