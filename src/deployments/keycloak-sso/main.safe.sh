if [ -z "$keycloakSSORegistered" ]; then
  crName="tyk-sso";
  secret="5yCQ2p8hg7jz4NwHo5QAqP0PqSOgMpKv";

  keycloakSSORegistered=true;
  source "src/deployments/keycloak/main.safe.sh";
  source "src/deployments/keycloak-sso/checks.sh";
  source "src/deployments/keycloak-sso/main.sh";
fi
