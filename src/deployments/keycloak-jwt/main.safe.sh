keycloakJWTDeploymentPath="src/deployments/keycloak-jwt";

if [ -z "$keycloaJWTPassGrantORegistered" ]; then
  keycloakJWTPassGrantRegistered=true;
  crName="tyk-jwt";
  secret="wcl7lBoslXBMAHKinMwa1bbEuBQSCUtI";

  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/keycloak/main.safe.sh";
  source "$keycloakJWTDeploymentPath/main.sh";
fi
