logger "$INFO" "installing portal in $namespace namespace...";

portalDBName=portal;
portalDBPort=54321;
source src/main/storage/pgsql.sh $portalDBName $portalDBPort;

addService "enterprise-portal-svc-$tykReleaseName-tyk-enterprise-portal";

args=(
  --set "global.components.enterprisePortal=true" \
  --set "tyk-enterprise-portal.license=$PORTAL_LICENSE" \
  --set "tyk-enterprise-portal.image.tag=$PORTAL_VERSION" \
  --set "tyk-enterprise-portal.containerPort=$PORTAL_SERVICE_PORT" \
  --set "tyk-enterprise-portal.database.dialect=postgres" \
  --set "tyk-enterprise-portal.database.connectionString=host\=tyk-$portalDBName-postgres-postgresql.$namespace.svc port\=$portalDBPort user\=postgres password\=$TYK_PASSWORD database\=$portalDBName sslmode\=disable" \
  "${portalSecurityContextArgs[@]}" \
  "${portalSSLArgs[@]}" \
  "${portalLoadbalancerArgs[@]}" \
  "${portalIngressArgs[@]}" \
);

addDeploymentArgs "${args[@]}";
upgradeTyk;
