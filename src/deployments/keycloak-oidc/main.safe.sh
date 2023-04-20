if [ -z "$keycloaJOIDCRegistered" ]; then
  crName="tyk-oidc";
  secret="5yCQ2p8hg7jz4NwHo5QAqP0PqSOgMpKv";

  keycloakOIDCRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "src/deployments/keycloak-oidc/main.sh";
fi
