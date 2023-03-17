deploymentPath="src/deployments/keycloak";

source src/deployments/keycloak/operator.sh;

logger "$INFO" "installing keycloak...";
source src/deployments/keycloak/storage.sh;

logger "$DEBUG" "keycloak: creating keycloak tls secret...";
kubectl create secret tls keycloak-tls-secret \
  --cert "$deploymentPath/certificate.pem" \
  --key "$deploymentPath/key.pem" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addService "https-$keycloakName-service";
sed "s/replace_name/$keycloakName/g" "$deploymentPath/keycloak-template.yaml" | \
sed "s/replace_host/tyk-$keycloakDBName-postgres-postgresql.$namespace.svc/g" | \
sed "s/replace_port/$keycloakDBPort/g" | \
sed "s/replace_database/$keycloakDBName/g" | \
sed "s/replace_service_port/$KEYCLOAK_SERVICE_PORT/g" | \
	kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "waiting for keycloak pods to come up...";
waitForKeycloakPods;
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for condition=Ready --timeout=180s  > /dev/null;

addSummary "\n\
\tKeycloak deployed\n \
\tusername: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.username}' --namespace "$namespace" | base64 --decode)\n \
\tpassword: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.password}' --namespace "$namespace" | base64 --decode)\n";

logger "$INFO" "installed keycloak in namespace $namespace";
