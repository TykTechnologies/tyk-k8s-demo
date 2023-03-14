keycloak_url=https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes;
deploymentPath="src/deployments/keycloak";

logger "$INFO" "installing keycloak...";

keycloakDBName=keycloak;
keycloakDBPort=54322;
source src/main/pgsql.sh $keycloakDBName $keycloakDBPort;

logger "$INFO" "installing keycloak operator...";
kubectl apply -f "$keycloak_url/keycloaks.k8s.keycloak.org-v1.yml" --namespace "$namespace" > /dev/null;
kubectl apply -f "$keycloak_url/keycloakrealmimports.k8s.keycloak.org-v1.yml" --namespace "$namespace" > /dev/null;
kubectl apply -f "$keycloak_url/kubernetes.ym"l --namespace "$namespace" > /dev/null;

logger "$INFO" "waiting for keycloak operator pods to come up...";
kubectl wait pods --namespace "$namespace" -l app.kubernetes.io/name=keycloak-operator --for condition=Ready --timeout=180s  > /dev/null;

logger "$INFO" "creating keycloak database secret...";
kubectl create secret generic keycloak-db-secret \
  --from-literal="username=postgres" \
  --from-literal="password=$PASSWORD" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "creating keycloak tls secret...";
kubectl create secret tls keycloak-tls-secret \
  --cert "$deploymentPath/certificate.pem" \
  --key "$deploymentPath/key.pem" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "installing keycloak...";

addService "https-$keycloakName-service";
sed "s/replace_name/$keycloakName/g" "$deploymentPath/keycloak-template.yaml" | \
sed "s/replace_host/tyk-$keycloakDBName-postgres-postgresql.$namespace.svc/g" | \
sed "s/replace_port/$keycloakDBPort/g" | \
sed "s/replace_database/$keycloakDBName/g" | \
sed "s/replace_service_port/$KEYCLOAK_SERVICE_PORT/g" | \
	kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "waiting for keycloak pods to come up...";
sleep 10;
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for condition=Ready --timeout=180s  > /dev/null;

addSummary "\n\
\tKeycloak deployed\n \
\tusername: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.username}' --namespace "$namespace" | base64 --decode)\n \
\tpassword: $(kubectl get secret "$keycloakName-initial-admin" -o jsonpath='{.data.password}' --namespace "$namespace" | base64 --decode)\n";

logger "$INFO" "installed keycloak in namespace $namespace";
