source src/namespace.sh;
source src/redis.sh;

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.rpc.connString=$TYK_HYBRID_CONNECTIONSTRING" \
  --set "gateway.rpc.rpcKey=$TYK_HYBRID_ORGID" \
  --set "gateway.rpc.apiKey=$TYK_HYBRID_AUTHTOKEN" \
  --set "gateway.service.port=8080");

tykReleaseName="tyk-hybrid-tyk-hybrid";
checkTykRelease;

set -x
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/tyk-hybrid \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --wait
set +x

addService "gateway-svc-$tykReleaseName";
