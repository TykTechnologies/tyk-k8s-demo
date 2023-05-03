keycloakDCRDeploymentPath="src/deployments/keycloak-dcr";

if [ -z "$keycloakDCRRegistered" ]; then
  keycloakDCRRegistered=true;
  crName="tyk-dcr";

  source "src/deployments/portal/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "$keycloakDCRDeploymentPath/main.sh";
fi
