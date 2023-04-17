deploymentPath="src/deployments/keycloak-jwt-client-creds";
crName="tyk-jwt-client-creds";
secret="fdQsoBJX5R04sF6bcZ0lIlJNtBGiaZTc";

logger "$INFO" "installing keycloak jwt-client-creds realm in $namespace namespace...";

sed "s/replace_cr_name/$crName/g" "$deploymentPath/realm-template.yaml" | \
sed "s/replace_keycloak/$keycloakName/g" | \
sed "s/replace_username/$USERNAME/g" | \
sed "s/replace_password/$PASSWORD/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$DEBUG" "keycloak-jwt-client-creds: waiting for $crName to be created";
waitForPods "job-name=$crName" "$crName";
kubectl wait --namespace "$namespace" jobs "$crName" --for=condition=complete --timeout=120s > /dev/null;
kubectl delete --namespace "$namespace" jobs "$crName" > /dev/null;

logger "$INFO" "waiting for keycloak to be ready...";
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=delete --timeout=60s > /dev/null;
waitForPods "statefulset.kubernetes.io/pod-name=$keycloakName-0" "$keycloakName-0";
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout=180s > /dev/null;

sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$deploymentPath/api-template.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  sed "s/replace_realm_url/https:\/\/$keycloakName-service.$namespace.svc:$KEYCLOAK_SERVICE_PORT\/realms\/jwt-client-creds/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

addSummary "\tJWT Client Credentials flow Example deployed. To generate your JWT:\n \
\ttoken=\$(curl -L --insecure -s -X POST 'https://localhost:$KEYCLOAK_SERVICE_PORT/realms/jwt-client-creds/protocol/openid-connect/token' \\\\\n\
\t\t-H 'Content-Type: application/x-www-form-urlencoded' \\\\\n\
\t\t--data-urlencode 'client_id=jwt-client-creds' \\\\\n\
\t\t--data-urlencode 'grant_type=client_credentials' \\\\\n\
\t\t--data-urlencode 'client_secret=$secret' | jq -r '.access_token')\n
\tTo test API Access:\n \
\tcurl 'http://localhost:8080/jwt-client-creds/get' \\\\\n\
\t\t-H \"Authorization: Bearer \$token\"";
