source src/main/namespace.sh;
source src/main/redis.sh;

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.rpc.connString=$TYK_HYBRID_CONNECTIONSTRING" \
  --set "gateway.rpc.rpcKey=$TYK_HYBRID_ORGID" \
  --set "gateway.rpc.apiKey=$TYK_HYBRID_AUTHTOKEN" \
  --set "gateway.rpc.useSSL=$TYK_HYBRID_USESSL" \
  --set "gateway.service.port=8081");

tykReleaseName="tyk-hybrid-tyk-hybrid";
checkTykRelease;

setVerbose;
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/tyk-hybrid \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addService "gateway-svc-$tykReleaseName";
addSummary "\n\
\tTyk Hybrid Gateway deployed\n
\tMDCB connection: $TYK_HYBRID_CONNECTIONSTRING\n";

logger $INFO "installed tyk in namespace $namespace";
