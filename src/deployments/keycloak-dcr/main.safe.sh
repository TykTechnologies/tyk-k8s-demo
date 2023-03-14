if [ -z "$keycloakDCRRegistered" ]; then
  keycloakDCRRegistered=true;
  source "src/deployments/keycloak/main.safe.sh";
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak-dcr/main.sh";
fi
