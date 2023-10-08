source "$keycloakDeploymentPath/operator.sh";

logger "$INFO" "installing $keycloakName in $namespace namespace...";
source "$keycloakDeploymentPath/storage.sh";

logger "$DEBUG" "keycloak: creating keycloak initial credentials...";
kubectl create secret generic "$keycloakName-initial-admin" \
  --from-literal="username=$TYK_USERNAME" \
  --from-literal="password=$TYK_PASSWORD" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addService "$keycloakName-service";
sed "s/replace_name/$keycloakName/g" "$keycloakDeploymentPath/keycloak-template.yaml" | \
  sed "s/replace_db_host/tyk-$keycloakDBName-postgres-postgresql.$namespace.svc/g" | \
  sed "s/replace_db_port/$keycloakDBPort/g" | \
  sed "s/replace_db_name/$keycloakDBName/g" | \
  sed "s/replace_service_port/$KEYCLOAK_SERVICE_PORT/g" | \
	kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "waiting for $keycloakName pods to come up...";
waitForPods "statefulset.kubernetes.io/pod-name=$keycloakName-0" "$keycloakName-0";
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout="$TYK_TIMEOUT" > /dev/null;

addSummary "\tKeycloak deployed\n \
\tUsername: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.username}' --namespace "$namespace" | base64 --decode)\n \
\tPassword: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.password}' --namespace "$namespace" | base64 --decode)";
