args=(
  --set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=TYK_GW_DISABLEPORTWHITELIST" \
  --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=true" \
  --set "tyk-pump.pump.backend[0]=" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub" \
);
gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));

tykReleaseName="tyk-oss";
tykReleaseVersion="2.2.0";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
addDeploymentArgs "${loadbalancerArgs[@]}";
addDeploymentArgs "${ingressArgs[@]}";
upgradeTyk;

addSummary "\tTyk Gateway deployed";
