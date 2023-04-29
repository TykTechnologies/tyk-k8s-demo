keycloakSSODeploymentPath="src/deployments/keycloak-sso";

if [ -z "$keycloakSSORegistered" ]; then
  keycloakSSORegistered=true;
  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakSSODeploymentPath/checks.sh";
  source "$keycloakSSODeploymentPath/main.sh";
fi
