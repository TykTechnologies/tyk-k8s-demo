source src/main/namespace.sh;
source src/main/redis/main.sh;
source src/main/storage/main.sh;

args=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.email=$USERNAME" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$DASHBOARD_VERSION" \
  --set "gateway.image.tag=$GATEWAY_VERSION" \
  --set "pump.image.tag=$PUMP_VERSION" \
  --set "pump.image.repository=tykio/tyk-pump-docker-pub");

tykReleaseName="tyk-stack";
addService "dashboard-svc-$tykReleaseName-$chart";
addService "gateway-svc-$tykReleaseName-$chart";
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
