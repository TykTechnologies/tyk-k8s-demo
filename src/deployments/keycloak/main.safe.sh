KEYCLOAK_SERVICE_PORT=7000;
keycloak_url=https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes;
deploymentPath="src/deployments/keycloak";
keycloakName="tyk-keycloak";
keycloakDBName=keycloak;
keycloakDBPort=54322;

if ! $keycloakRegistered; then
  keycloakRegistered=true;
  source "src/deployments/keycloak/main.sh";
fi

addService "https-$keycloakName-service";
