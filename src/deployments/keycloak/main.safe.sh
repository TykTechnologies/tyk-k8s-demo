KEYCLOAK_SERVICE_PORT=7000;
keycloakName="keycloak";

if [ -z "$keycloakRegistered" ]; then
  keycloakRegistered=true;
  source "src/deployments/keycloak/main.sh";
fi
