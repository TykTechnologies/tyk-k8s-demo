logger "$INFO" "installing keycloak jwt realm in $namespace namespace...";

crName="tyk-jwt";
secret="wcl7lBoslXBMAHKinMwa1bbEuBQSCUtI";

checkKeycloakRealmImportCRExists "$crName";
if ! $keycloakRealmImportCRExists; then
sed "s/replace_cr_name/$crName/g" "$keycloakJWTDeploymentPath/realm-template.yaml" | \
    sed "s/replace_keycloak/$keycloakName/g" | \
    sed "s/replace_username/$TYK_USERNAME/g" | \
    sed "s/replace_password/$TYK_PASSWORD/g" | \
    sed "s/replace_secret/$secret/g" | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;

  logger "$DEBUG" "keycloak-jwt: waiting for $crName to be created";
  waitForPods "job-name=$crName" "$crName";
  kubectl wait --namespace "$namespace" jobs "$crName" --for=condition=complete --timeout=120s > /dev/null;

  logger "$INFO" "waiting for keycloak to be ready...";
  kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=delete --timeout=60s > /dev/null;
  waitForPods "statefulset.kubernetes.io/pod-name=$keycloakName-0" "$keycloakName-0";
  kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout=180s > /dev/null;
fi

sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$keycloakJWTDeploymentPath/api-template.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  sed "s/replace_realm_url/http:\/\/$keycloakName-service.$namespace.svc:$KEYCLOAK_SERVICE_PORT\/realms\/jwt/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

addSummary "\tJWT Authentication Example deployed. To generate your JWT:\n \
\tPassword Grant request:\n \
\ttoken=\$(curl -L --insecure -s -X POST 'http://localhost:$KEYCLOAK_SERVICE_PORT/realms/jwt/protocol/openid-connect/token' \\\\\n\
\t\t-H 'Content-Type: application/x-www-form-urlencoded' \\\\\n\
\t\t--data-urlencode 'client_id=keycloak-jwt' \\\\\n\
\t\t--data-urlencode 'grant_type=password' \\\\\n\
\t\t--data-urlencode 'client_secret=$secret' \\\\\n\
\t\t--data-urlencode 'scope=openid' \\\\\n\
\t\t--data-urlencode 'username=$TYK_USERNAME' \\\\\n\
\t\t--data-urlencode 'password=$TYK_PASSWORD' | jq -r '.access_token')\n
\tClient Credentials request:\n \
\ttoken=\$(curl -L --insecure -s -X POST 'http://localhost:$KEYCLOAK_SERVICE_PORT/realms/jwt/protocol/openid-connect/token' \\\\\n\
\t\t-H 'Content-Type: application/x-www-form-urlencoded' \\\\\n\
\t\t--data-urlencode 'client_id=keycloak-jwt' \\\\\n\
\t\t--data-urlencode 'grant_type=client_credentials' \\\\\n\
\t\t--data-urlencode 'client_secret=$secret' | jq -r '.access_token')\n
\tTo test API Access:\n \
\tcurl 'http://localhost:8080/keycloak-jwt/get' \\\\\n\
\t\t-H \"Authorization: Bearer \$token\"";
