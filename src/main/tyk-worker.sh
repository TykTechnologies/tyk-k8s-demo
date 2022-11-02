source src/main/namespace.sh;
source src/main/redis.sh;

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.rpc.connString=$TYK_WORKER_CONNECTIONSTRING" \
  --set "gateway.rpc.rpcKey=$TYK_WORKER_ORGID" \
  --set "gateway.rpc.apiKey=$TYK_WORKER_AUTHTOKEN" \
  --set "gateway.rpc.useSSL=$TYK_WORKER_USESSL" \
  --set "gateway.rpc.groupId=$(date | base64)" \
  --set "gateway.service.port=$TYK_WORKER_GW_PORT" \
  --set "gateway.extraEnvs[0].name=TYK_GW_SLAVEOPTIONS_SYNCHRONISERENABLED" \
  --set "gateway.extraEnvs[0].value=true");

tykReleaseName="tyk-worker-tyk-hybrid";
addService "gateway-svc-$tykReleaseName";
addServiceArgs "gateway";
checkTykRelease;

setVerbose;
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/tyk-hybrid \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  "${servicesArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

if ! $dryRun; then
  source src/helpers/set-worker-args.sh;
fi

addSummary "\n\
\tTyk Worker Gateway deployed\n
\tMDCB Connection: $TYK_WORKER_CONNECTIONSTRING
\tGateway URL: http://$ip:$port\n";

logger $INFO "installed tyk in namespace $namespace";
