if ! $keycloakDCRRegistered; then
  keycloakDCRRegistered=true;
  source "src/deployments/keycloak-dcr/main.sh";
fi
