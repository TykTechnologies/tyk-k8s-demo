if [ -z "$keycloakSSORegistered" ]; then
  keycloakSSORegistered=true;
  source "src/deployments/keycloak/main.safe.sh";
  source "src/deployments/keycloak-sso/main.sh";
fi
