KEYCLOAK_SERVICE_PORT=7001;
keycloakName="keycloak";

if [ -z "$keycloakRegistered" ]; then
  keycloakRegistered=true;
  source "src/deployments/self-signed-certs/main.safe.sh";
  source "src/deployments/keycloak/openshift.sh";
  source "src/deployments/keycloak/main.sh";
fi
