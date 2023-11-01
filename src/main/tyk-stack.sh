source src/main/storage/main.sh;

tykReleaseName="tyk-stack";
args=(--set "global.license.dashboard=$LICENSE" \
  --set "tyk-bootstrap.adminUser.email=$TYK_USERNAME" \
  --set "tyk-bootstrap.adminUser.password=$TYK_PASSWORD" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-dashboard.dashboard.image.tag=$DASHBOARD_VERSION" \
  --set "tyk-pump.pump.image.tag=$PUMP_VERSION" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub");

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
