keycloakDBName=keycloak;
keycloakDBPort=54322;
source src/main/storage/pgsql.sh $keycloakDBName $keycloakDBPort;

logger "$DEBUG" "keycloak/storage/main.sh: creating keycloak database secret...";
kubectl create secret generic keycloak-db-secret \
  --from-literal="username=postgres" \
  --from-literal="password=$TYK_PASSWORD" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
