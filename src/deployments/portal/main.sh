logger "$INFO" "installing portal in $namespace namespace...";

portalDBName=portal;
portalDBPort=54321;
source src/main/storage/pgsql.sh $portalDBName $portalDBPort;

addService "enterprise-portal-svc-$tykReleaseName";
addServiceArgs "enterprisePortal";

args=(--set "enterprisePortal.license=$PORTAL_LICENSE" \
  --set "enterprisePortal.enabled=true" \
  --set "enterprisePortal.image.tag=$PORTAL_VERSION" \
  --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDBName-postgres-postgresql.$namespace.svc port\=$portalDBPort user\=postgres password\=$PASSWORD database\=$portalDBName sslmode\=disable" \
  "${portalSecurityContextArgs[@]}");

addDeploymentArgs "${args[@]}";
upgradeTyk;
