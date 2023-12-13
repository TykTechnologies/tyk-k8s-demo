if [ -z "$keycloakSSORegistered" ]; then
  keycloakSSORegistered=true;

  keycloakSSODeploymentPath="src/deployments/keycloak-sso";

  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakSSODeploymentPath/checks.sh";
  source "$keycloakSSODeploymentPath/main.sh";
fi
