keycloakOIDCDeploymentPath="src/deployments/keycloak-oidc";

if [ -z "$keycloaJOIDCRegistered" ]; then
  keycloakOIDCRegistered=true;

  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakOIDCDeploymentPath/main.sh";
fi
