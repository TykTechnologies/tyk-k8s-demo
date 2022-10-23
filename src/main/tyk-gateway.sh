source src/main/namespace.sh;
source src/main/redis.sh;

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.image.repository=tykio/tyk-gateway" \
  --set "gateway.kind=Deployment" \
  --set "gateway.service.port=8080");

tykReleaseName="tyk-gateway-tyk-headless";
checkTykRelease;

setVerbose;
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/tyk-headless \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addService "gateway-svc-$tykReleaseName";
addSummary "\n\
\tTyk Gateway deployed\n";

logger $INFO "installed tyk in namespace $namespace";
