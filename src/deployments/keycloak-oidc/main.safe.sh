if [ -z "$keycloaJWTPClientCredsRegistered" ]; then
  keycloakJWTClientCredsRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "src/deployments/keycloak-jwt-client-creds/main.sh";
fi
