keycloakOIDCDeploymentPath="src/deployments/keycloak-oidc";

if [ -z "$keycloaJOIDCRegistered" ]; then
  crName="tyk-oidc";
  client_id="oidc-client";
  secret="5yCQ2p8hg7jz4NwHo5QAqP0PqSOgMpKv";

  keycloakOIDCRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakOIDCDeploymentPath/main.sh";
fi
