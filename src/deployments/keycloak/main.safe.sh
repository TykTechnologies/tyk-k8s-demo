if [ -z "$keycloakRegistered" ]; then
  keycloakRegistered=true;

  KEYCLOAK_SERVICE_PORT=7001;
  keycloakName="keycloak";
  keycloakDeploymentPath="src/deployments/keycloak";

  source "$keycloakDeploymentPath/helpers.sh";
  source "$keycloakDeploymentPath/ssl.sh";
  source "$keycloakDeploymentPath/main.sh";
fi
