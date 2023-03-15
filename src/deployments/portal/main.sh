logger "$INFO" "installing portal in $namespace namespace...";

if [[ $TYKPRO != "$mode" ]] && [[ $TYKCP != "$mode" ]]; then
  logger "$ERROR" "can only install the enterprise portal with a tyk-pro or a tyk-cp installation";
  exit 1;
fi

if [[ -z "$PORTAL_LICENSE" ]]; then
  logger "$ERROR" "Please make sure the PORTAL_LICENSE variable is set in your .env file";
  exit 1;
else
  checkLicense "$PORTAL_LICENSE"
  if $expired; then
    logger "$ERROR" "Your Enterprise Portal license has expired or is invalid. Please provide another license key";
    exit 1;
  fi
fi

portalDBName=portal;
portalDBPort=54321;
source src/main/pgsql.sh $portalDBName $portalDBPort;

addService "enterprise-portal-svc-$tykReleaseName";
addServiceArgs "enterprisePortal";

args=(--set "enterprisePortal.license=$PORTAL_LICENSE" \
  --set "enterprisePortal.enabled=true" \
  --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDBName-postgres-postgresql.$namespace.svc port\=$portalDBPort user\=postgres password\=$PASSWORD database\=$portalDBName sslmode\=disable" \
  "${potalSecurityContextArgs[@]}");

addDeploymentArgs "${args[@]}";
