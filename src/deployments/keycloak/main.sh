deploymentPath="src/deployments/keycloak";

source src/deployments/keycloak/operator.sh;

logger "$INFO" "installing $keycloakName in $namespace namespace...";
source src/deployments/keycloak/storage.sh;

logger "$DEBUG" "keycloak: creating keycloak initial credentials...";
kubectl create secret generic "$keycloakName-initial-admin" \
  --from-literal="username=$USERNAME" \
  --from-literal="password=$PASSWORD" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$DEBUG" "keycloak: creating keycloak tls secret...";
kubectl create secret tls keycloak-tls-secret \
  --cert "src/deployments/self-signed-certs/certs/tyk.local.crt" \
  --key "src/deployments/self-signed-certs/certs/tyk.local.key" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addService "https-$keycloakName-service";
sed "s/replace_name/$keycloakName/g" "$deploymentPath/keycloak-template.yaml" | \
sed "s/replace_host/tyk-$keycloakDBName-postgres-postgresql.$namespace.svc/g" | \
sed "s/replace_port/$keycloakDBPort/g" | \
sed "s/replace_database/$keycloakDBName/g" | \
sed "s/replace_service_port/$KEYCLOAK_SERVICE_PORT/g" | \
	kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "waiting for $keycloakName pods to come up...";
waitForPods "statefulset.kubernetes.io/pod-name=$keycloakName-0" "$keycloakName-0";
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout=180s > /dev/null;

addSummary "\tKeycloak deployed\n \
\tUsername: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.username}' --namespace "$namespace" | base64 --decode)\n \
\tPassword: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.password}' --namespace "$namespace" | base64 --decode)";
