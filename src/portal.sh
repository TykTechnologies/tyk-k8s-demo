portalDB=portal;
source src/pgsql.sh $portalDB;
source src/helpers/portal-exists.sh;

if $portalExists; then
  logger $INFO "tyk-portal already exists in $namespace namespace...skipping Tyk Enterprise Portal install";
else
  set -x
  helm upgrade tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
    -n $namespace \
    "${tykArgs[@]}" \
    "${tykRedisArgs[@]}" \
    "${tykDatabaseArgs[@]}" \
    "${tykSecurityContextArgs[@]}" \
    "${gatewaySecurityContextArgs[@]}" \
    --set "enterprisePortal.license=$PORTAL_LICENSE" \
    --set "enterprisePortal.enabled=true" \
    --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDB-postgres-postgresql.$namespace.svc.cluster.local port\=5432 user\=postgres password\=$PASSWORD database\=$portalDB sslmode\=disable" \
    "${potalSecurityContextArgs[@]}" \
    --wait
  set +x
fi
