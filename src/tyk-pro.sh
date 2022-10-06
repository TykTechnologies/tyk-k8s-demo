#!/bin/bash
set -e

kubectl create ns $namespace
if [ $flavor == "openshift" ]; then
  source src/os.sh;
fi

source src/redis.sh;
source src/mongo.sh;

helm install tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  --wait \
  --set "redis.addrs[0]=tyk-redis-master.$namespace.svc.cluster.local:6379" \
  --set "redis.pass=topsecretpassword" \
  --set "mongo.mongoURL=mongodb://root:topsecretpassword@tyk-mongo-mongodb.$namespace.svc.cluster.local:27017/tyk_analytics?authSource=admin" \
  --set "dash.license=$LICENSE" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "dash.adminUser.password=topsecretpassword" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION"
