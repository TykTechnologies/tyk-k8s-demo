logger "$INFO" "creating Tyk Operator JWT HMAC example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorJWTHMACDeploymentPath/api-template.yaml" | \
  sed "s/replace_shared_secret/$(echo -n "$secret" | basenc --base64url)/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;

addSummary "\tJWT HMAC Authentication Example deployed.\n \
\tYou can generate your own JWT using this secret: $secret\n \
\tOr you can use this JWT: \n \
\ttoken='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.8TKYxZ1838CRmpf7cZ2tU673Jm1swSfb-Mgp9AwzIv0'\n
\tTo test API Access:\n \
\tcurl 'http://localhost:8080/jwt-hmac/get' \\\\\n\
\t\t-H \"Authorization: Bearer \$token\"";
