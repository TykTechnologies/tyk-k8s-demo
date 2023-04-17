keycloak_url=https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes;

logger "$INFO" "installing keycloak operator in $namespace namespace...";
kubectl apply -f "$keycloak_url/keycloaks.k8s.keycloak.org-v1.yml" --namespace "$namespace" > /dev/null;
kubectl apply -f "$keycloak_url/keycloakrealmimports.k8s.keycloak.org-v1.yml" --namespace "$namespace" > /dev/null;
kubectl apply -f "$keycloak_url/kubernetes.yml" --namespace "$namespace" > /dev/null;

logger "$DEBUG" "keycloak/operator.sh: waiting for keycloak operator pods to come up...";
kubectl wait pods --namespace "$namespace" -l app.kubernetes.io/name=keycloak-operator --for=condition=Ready --timeout=500s  > /dev/null;
