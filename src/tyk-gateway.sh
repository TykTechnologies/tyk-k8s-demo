source src/namespace.sh;
source src/redis.sh;

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.image.repository=tykio/tyk-gateway" \
  --set "gateway.kind=Deployment" \
  --set "gateway.service.port=8080")

set -x
helm install tyk-gateway $TYK_HELM_CHART_PATH/tyk-headless \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  --wait
set +x
