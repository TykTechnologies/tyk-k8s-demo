logger $DEBUG "Installing enterprise portal";

if [[ $TYKPRO != $mode ]] && [[ $TYKCP != $mode ]]; then
  logger $ERROR "can only install the enterprise portal with a tyk-pro or a tyk-cp installation";
  exit 1;
fi

portalDBName=portal;
portalDBPort=54321;
source src/main/pgsql.sh $portalDBName $portalDBPort;
source src/main/helpers/portal-exists.sh;

addService "enterprise-portal-svc-$tykReleaseName";

if $portalExists; then
  logger $INFO "tyk-portal already exists in $namespace namespace...skipping Tyk Enterprise Portal install";
else
  set -x
  helm upgrade $tykReleaseName $TYK_HELM_CHART_PATH/tyk-pro \
    -n $namespace \
    "${tykArgs[@]}" \
    "${tykRedisArgs[@]}" \
    "${tykStorageArgs[@]}" \
    "${tykSecurityContextArgs[@]}" \
    "${gatewaySecurityContextArgs[@]}" \
    --set "enterprisePortal.license=$PORTAL_LICENSE" \
    --set "enterprisePortal.enabled=true" \
    --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDBName-postgres-postgresql.$namespace.svc.cluster.local port\=$portalDBPort user\=postgres password\=$PASSWORD database\=$portalDBName sslmode\=disable" \
    "${potalSecurityContextArgs[@]}" \
    --wait
  set +x
fi
