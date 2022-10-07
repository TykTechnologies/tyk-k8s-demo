portalDB=portal
source src/pgsql.sh $portalDB;

set -x
# Hack until code is merged
kubectl create secret -n $namespace generic tyk-enterprise-portal-conf \
  --from-literal "TYK_AUTH=$(kubectl get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_AUTH}' | base64 -d)" \
  --from-literal "TYK_ORG=$(kubectl get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_ORG}' | base64 -d)"

helm upgrade tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykDatabaseArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  --set "enterprisePortal.license=$PORTAL_LICENSE" \
  --set "enterprisePortal.enabled=true" \
  --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDB-postgres-postgresql.$namespace.svc.cluster.local port\=5432 user\=postgres password\=topsecretpassword database\=$portalDB sslmode\=disable" \
  "${potalSecurityContextArgs[@]}" \
  --wait
set +x
