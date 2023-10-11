keycloakTemplate="keycloak-template.yaml";
if [[ "$SSL" == "$SSLMode" ]]; then
  keycloakTemplate="keycloak-ssl-template.yaml";

  logger "$DEBUG" "keycloak: creating keycloak tls secret...";
  kubectl create secret tls keycloak-tls-secret \
    --cert "$certsPath/$certFilename" \
    --key "$certsPath/$keyFilename" \
    --dry-run=client -o=yaml | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;
fi
