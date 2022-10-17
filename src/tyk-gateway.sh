source src/namespace.sh;
source src/redis.sh;

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.image.repository=tykio/tyk-gateway" \
  --set "gateway.kind=Deployment" \
  --set "gateway.service.port=8080");

tykReleaseName="tyk-gateway-tyk-headless";
checkTykRelease;

set -x
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/tyk-headless \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --wait
set +x

addService "gateway-svc-$tykReleaseName";
