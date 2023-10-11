if [ -z "$keycloaJWTPassGrantORegistered" ]; then
  keycloakJWTPassGrantRegistered=true;

  keycloakJWTDeploymentPath="src/deployments/keycloak-jwt";

  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakJWTDeploymentPath/main.sh";
fi
