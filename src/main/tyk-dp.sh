cluster=$(kubectl config current-context);

groupID=$(echo "$cluster/$namespace" | base64)
args=(--set "global.remoteControlPlane.connectionString=$TYK_WORKER_CONNECTIONSTRING" \
  --set "global.remoteControlPlane.orgId=$TYK_WORKER_ORGID" \
  --set "global.remoteControlPlane.userApiKey=$TYK_WORKER_AUTHTOKEN" \
  --set "global.remoteControlPlane.useSSL=$TYK_WORKER_USESSL" \
  --set "global.remoteControlPlane.groupId=$groupID" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.sharding.enabled=$TYK_WORKER_SHARDING_ENABLED" \
  --set "tyk-gateway.gateway.sharding.tags=$TYK_WORKER_SHARDING_TAGS" \
  --set "tyk-gateway.gateway.service.port=$TYK_WORKER_GW_PORT" \
  --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=TYK_GW_SLAVEOPTIONS_USERPC" \
  --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=true" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 1))].name=TYK_GW_AUTHOVERRIDE_FORCEAUTHPROVIDER" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 1))].value=true" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 2))].name=TYK_GW_SLAVEOPTIONS_RPCKEY" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 2))].value=$TYK_WORKER_ORGID" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 3))].name=TYK_GW_SLAVEOPTIONS_APIKEY" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 3))].value=$TYK_WORKER_AUTHTOKEN" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 4))].name=TYK_GW_SLAVEOPTIONS_GROUPID" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 4))].value=$groupID" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 5))].name=TYK_GW_SLAVEOPTIONS_CONNECTIONSTRING" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 5))].value=$TYK_WORKER_CONNECTIONSTRING" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 6))].name=TYK_GW_SLAVEOPTIONS_USESSL" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 6))].value=$TYK_WORKER_USESSL" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 7))].name=TYK_GW_SLAVEOPTIONS_SSLINSECURESKIPVERIFY" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 7))].value=true" \
  );

gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 8));


if [ -z "$TYK_WORKER_SHARDING_TAGS" ]
then
      tykReleaseName="tyk-dp";
else
      tykReleaseName="tyk-dp-$TYK_WORKER_SHARDING_TAGS";
fi
logger "$DEBUG" "tykReleaseName=$tykReleaseName";

addService "gateway-svc-$tykReleaseName-tyk-gateway";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
upgradeTyk;

if [[ -n "$TYK_WORKER_OPERATOR_CONNECTIONSTRING" ]]; then
  logger "$INFO" "creating tyk-operator secret...";
  kubectl create secret generic tyk-operator-conf \
    --from-literal="TYK_MODE=pro" \
    --from-literal="TYK_URL=$TYK_WORKER_OPERATOR_CONNECTIONSTRING" \
    --from-literal="TYK_AUTH=$TYK_WORKER_AUTHTOKEN" \
    --from-literal="TYK_ORG=$TYK_WORKER_ORGID" \
    --dry-run=client -o=yaml | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;
fi

addSummary "\tTyk Worker Gateway deployed\n
\tMDCB Connection: $TYK_WORKER_CONNECTIONSTRING";
