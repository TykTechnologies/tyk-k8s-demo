logger "$INFO" "installing keycloak oidc realm in $namespace namespace...";

crName="tyk-oidc";
client_id="oidc-client";
secret="5yCQ2p8hg7jz4NwHo5QAqP0PqSOgMpKv";
checkKeycloakRealmImportCRExists "$crName";
if ! $keycloakRealmImportCRExists; then
  sed "s/replace_cr_name/$crName/g" "$keycloakOIDCDeploymentPath/realm-template.yaml" | \
    sed "s/replace_keycloak/$keycloakName/g" | \
    sed "s/replace_username/$USERNAME/g" | \
    sed "s/replace_password/$PASSWORD/g" | \
    sed "s/replace_secret/$secret/g" | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;

  logger "$DEBUG" "keycloak-oidc: waiting for $crName to be created";

  waitForPods "job-name=$crName" "$crName";
  kubectl wait --namespace "$namespace" jobs "$crName" --for=condition=complete --timeout=120s > /dev/null;

  logger "$INFO" "waiting for keycloak to be ready...";
  kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=delete --timeout=60s > /dev/null;
  waitForPods "statefulset.kubernetes.io/pod-name=$keycloakName-0" "$keycloakName-0";
  kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout=180s > /dev/null;
fi

sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$keycloakOIDCDeploymentPath/api-template.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  sed "s/replace_realm_url/https:\/\/$keycloakName-service.$namespace.svc:$KEYCLOAK_SERVICE_PORT\/realms\/oidc/g" | \
  sed "s/replace_client_id/$(base64 $client_id)/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

addSummary "\tJWT Password Grant flow Example deployed. To generate your JWT:\n \
\ttoken=\$(curl -L --insecure -s -X POST 'https://keycloak-service.tyk.svc:$KEYCLOAK_SERVICE_PORT/realms/oidc/protocol/openid-connect/token' \\\\\n\
\t\t-H 'Content-Type: application/x-www-form-urlencoded' \\\\\n\
\t\t--data-urlencode 'client_id=$client_id' \\\\\n\
\t\t--data-urlencode 'grant_type=password' \\\\\n\
\t\t--data-urlencode 'client_secret=$secret' \\\\\n\
\t\t--data-urlencode 'scope=openid' \\\\\n\
\t\t--data-urlencode 'username=$USERNAME' \\\\\n\
\t\t--data-urlencode 'password=$PASSWORD' | jq -r '.access_token')\n
\tTo test API Access:\n \
\tcurl 'http://localhost:8080/keycloak-oidc/get' \\\\\n\
>>>>>>> 2f2fd50 (Save work)
\t\t-H \"Authorization: Bearer \$token\"";
