if [ -z "$TYK_DATA_PLANE_GROUPID" ]; then
  TYK_DATA_PLANE_GROUPID=$(echo "$(kubectl config current-context | base64)/$namespace");
fi

args=(
  --set "global.remoteControlPlane.connectionString=$TYK_DATA_PLANE_CONNECTIONSTRING" \
  --set "global.remoteControlPlane.orgId=$TYK_DATA_PLANE_ORGID" \
  --set "global.remoteControlPlane.userApiKey=$TYK_DATA_PLANE_AUTHTOKEN" \
  --set "global.remoteControlPlane.useSSL=$TYK_DATA_PLANE_USESSL" \
  --set "global.remoteControlPlane.groupID=$TYK_DATA_PLANE_GROUPID" \
  --set "global.servicePorts.gateway=$TYK_DATA_PLANE_PORT" \
  --set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway-ee" \
  --set "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=TYK_GW_DISABLEPORTWHITELIST" \
  --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=true" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.sharding.enabled=$TYK_DATA_PLANE_SHARDING_ENABLED" \
  --set "tyk-gateway.gateway.sharding.tags=$TYK_DATA_PLANE_SHARDING_TAGS" \
);
gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));

if [ -z "$TYK_DATA_PLANE_SHARDING_TAGS" ]; then
      tykReleaseName="tyk-dp";
else
      tykReleaseName="tyk-dp-$TYK_DATA_PLANE_SHARDING_TAGS";
fi

tykReleaseVersion="2.2.0";

logger "$DEBUG" "tykReleaseName=$tykReleaseName";

addService "gateway-svc-$tykReleaseName-tyk-gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
addDeploymentArgs "${loadbalancerArgs[@]}";
addDeploymentArgs "${ingressArgs[@]}";
upgradeTyk;

if [[ -n "$TYK_DATA_PLANE_OPERATOR_CONNECTIONSTRING" ]]; then
  logger "$INFO" "creating tyk-operator secret...";
  kubectl create secret generic tyk-operator-conf \
    --from-literal="TYK_MODE=pro" \
    --from-literal="TYK_OPERATOR_LICENSEKEY=$OPERATOR_LICENSE" \
    --from-literal="TYK_URL=$TYK_DATA_PLANE_OPERATOR_CONNECTIONSTRING" \
    --from-literal="TYK_AUTH=$TYK_DATA_PLANE_AUTHTOKEN" \
    --from-literal="TYK_ORG=$TYK_DATA_PLANE_ORGID" \
    --dry-run=client -o=yaml | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;
fi

addSummary "\tTyk Worker Gateway deployed\n
\tMDCB Connection: $TYK_DATA_PLANE_CONNECTIONSTRING";
