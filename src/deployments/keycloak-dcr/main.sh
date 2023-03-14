logger "$INFO" "installing keycloak DCR realm...";

setVerbose;
sed "s/replace_keycloak/$keycloakName/g" src/deployments/keycloak-dcr/realm.yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;

logger "$INFO" "installed keycloak DCR realm...";
