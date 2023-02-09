source src/main/namespace.sh;
source src/main/redis.sh;

cluster=$(kubectl config current-context);

args=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.rpc.connString=$TYK_WORKER_CONNECTIONSTRING" \
  --set "gateway.rpc.rpcKey=$TYK_WORKER_ORGID" \
  --set "gateway.rpc.apiKey=$TYK_WORKER_AUTHTOKEN" \
  --set "gateway.rpc.useSSL=$TYK_WORKER_USESSL" \
  --set "gateway.rpc.groupId=$(echo "$cluster/$namespace" | base64)" \
  --set "gateway.sharding.enabled=$TYK_WORKER_SHARDING_ENABLED" \
  --set "gateway.sharding.tags=$TYK_WORKER_SHARDING_TAGS" \
  --set "gateway.service.port=$TYK_WORKER_GW_PORT");

if [ -z "$TYK_WORKER_SHARDING_TAGS" ]
then
      tykReleaseName="tyk-worker-tyk-hybrid";
else
      tykReleaseName="tyk-worker-tyk-hybrid-$TYK_WORKER_SHARDING_TAGS";
fi
logger "$DEBUG" "tykReleaseName=$tykReleaseName";

addService "gateway-svc-$tykReleaseName";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";

setVerbose;
helm upgrade $tykReleaseName "$TYK_HELM_CHART_PATH/$chart" \
  --install \
  -n "$namespace" \
  "${deploymentsArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addSummary "\n\
\tTyk Worker Gateway deployed\n
\tMDCB Connection: $TYK_WORKER_CONNECTIONSTRING\n";

logger "$INFO" "installed tyk in namespace $namespace";
