keycloakSSODeploymentPath="src/deployments/keycloak-sso";

if [ -z "$keycloakSSORegistered" ]; then
  crName="tyk-sso";
  secret="5yCQ2p8hg7jz4NwHo5QAqP0PqSOgMpKv";

  keycloakSSORegistered=true;
  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakSSODeploymentPath/checks.sh";
  source "$keycloakSSODeploymentPath/main.sh";
fi
