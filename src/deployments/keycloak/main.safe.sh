KEYCLOAK_SERVICE_PORT=7001;
keycloakName="keycloak";
keycloakDeploymentPath="src/deployments/keycloak";

if [ -z "$keycloakRegistered" ]; then
  keycloakRegistered=true;
  source "src/deployments/self-signed-certs/main.safe.sh";
  source "$keycloakDeploymentPath/helpers.sh";
  source "$keycloakDeploymentPath/main.sh";
fi
