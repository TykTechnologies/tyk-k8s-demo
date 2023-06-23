source src/main/namespace.sh;
source src/main/redis/main.sh;
source src/main/storage/main.sh;

args=(--set "global.license.dashboard=$LICENSE" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub" \
  --set "tyk-pump.pump.image.tag=$PUMP_VERSION" \
  --set "tyk-bootstrap.adminUser.email=$USERNAME" \
  --set "tyk-bootstrap.adminUser.password=$PASSWORD" \
  --set "tyk-dashboard.dashboard.image.tag=$DASHBOARD_VERSION");

tykReleaseName="tyk-stack";
addService "dashboard-svc-$tykReleaseName-tyk-dashboard";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
addServiceArgs "dash";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
upgradeTyk;

addSummary "\tTyk Stack deployed\n \
\tDashboard username: $USERNAME\n \
\tDashboard password: $PASSWORD";
