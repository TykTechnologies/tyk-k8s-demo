source src/main/storage/main.sh;

tykReleaseName="tyk-stack";
tykReleaseVersion="2.2.0";

args=(
  --set "global.license.dashboard=$LICENSE" \
  --set "global.license.operator=$OPERATOR_LICENSE" \
  --set "global.adminUser.email=$TYK_USERNAME" \
  --set "global.adminUser.password=$TYK_PASSWORD" \
  --set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway-ee" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=TYK_GW_DISABLEPORTWHITELIST" \
  --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=true" \
  --set "tyk-dashboard.dashboard.image.tag=$DASHBOARD_VERSION" \
  --set "tyk-pump.pump.image.tag=$PUMP_VERSION" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub" \
  --set "tyk-dashboard.tib.enabled=true" \
);
gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));

addService "dashboard-svc-$tykReleaseName-tyk-dashboard";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
addDeploymentArgs "${loadbalancerArgs[@]}";
addDeploymentArgs "${ingressArgs[@]}";
upgradeTyk;

addSummary "\tTyk Stack deployed\n \
\tDashboard username: $TYK_USERNAME\n \
\tDashboard password: $TYK_PASSWORD";
