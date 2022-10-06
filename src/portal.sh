#!/bin/bash
set -e

source src/pgsql.sh portal;

# kubectl create secret -n tyk generic tyk-enterprise-portal-conf \
#   --from-literal "TYK_AUTH=${$(k get secrets tyk-operator-conf -n tyk -o=jsonpath='{.data.TYK_AUTH}' | base64 -d)}" \
#   --from-literal "TYK_ORG=${$(k get secrets tyk-operator-conf -n tyk -o=jsonpath='{.data.TYK_ORG}' | base64 -d)}"

# helm upgrade tyk-pro ./tyk-pro \
#   -n tyk \
#   --set "redis.addrs[0]=tyk-redis-master.tyk.svc.cluster.local:6379" \
#   --set "redis.pass=$REDIS_PASSWORD" \
#   --set "mongo.mongoURL=mongodb://root:$MONGODB_ROOT_PASSWORD@tyk-mongo-mongodb.tyk.svc.cluster.local:27017/tyk_analytics?authSource=admin" \
#   --set "dash.license=$LICENSE" \
#   --set "dash.securityContext.fsGroup=$ID" \
#   --set "dash.securityContext.runAsUser=$ID" \
#   --set "dash.image.tag=v4.2.1" \
#   --set "enterprisePortal.license=$LICENSE" \
#   --set "enterprisePortal.enabled=true" \
#   --set "enterprisePortal.storage.database.connectionString=host\=tyk-postgres-postgresql.tyk.svc.cluster.local port\=5432 user\=postgres password\=$POSTGRES_PASSWORD database\=portal sslmode\=disable" \
#   --set "enterprisePortal.securityContext.fsGroup=$ID" \
#   --set "enterprisePortal.securityContext.runAsUser=$ID" \
#   --set "gateway.securityContext.fsGroup=$ID" \
#   --set "gateway.securityContext.runAsUser=$ID" \
#   --set "gateway.image.tag=v4.2.1" \
#   --set "pump.securityContext.fsGroup=$ID" \
#   --set "pump.securityContext.runAsUser=$ID"
