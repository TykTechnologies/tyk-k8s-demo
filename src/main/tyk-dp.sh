source src/main/namespace.sh;
source src/main/redis.sh;

cluster=$(kubectl config current-context);

args=(--set "gateway.image.tag=$GATEWAY_VERSION" \
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
      tykReleaseName="tyk-dp-tyk-hybrid";
else
      tykReleaseName="tyk-dp-tyk-hybrid-$TYK_WORKER_SHARDING_TAGS";
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
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --install \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null;

  if [[ -n "$TYK_WORKER_OPERATOR_CONNECTIONSTRING" ]]; then
    logger "$DEBUG" "creating tyk-operator secret...";
    kubectl create secret generic tyk-operator-conf \
      --from-literal="TYK_MODE=pro" \
      --from-literal="TYK_URL=$TYK_WORKER_OPERATOR_CONNECTIONSTRING" \
      --from-literal="TYK_AUTH=$TYK_WORKER_AUTHTOKEN" \
      --from-literal="TYK_ORG=$TYK_WORKER_ORGID" \
      --dry-run=client -o=yaml | \
      kubectl apply --namespace "$namespace" -f - > /dev/null;
  fi
unsetVerbose;

addSummary "\tTyk Worker Gateway deployed\n
\tMDCB Connection: $TYK_WORKER_CONNECTIONSTRING";
