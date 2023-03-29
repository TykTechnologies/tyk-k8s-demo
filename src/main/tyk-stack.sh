source src/main/namespace.sh;
source src/main/redis.sh;
source src/main/storage.sh;

args=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.email=$USERNAME" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$DASHBOARD_VERSION" \
  --set "gateway.image.tag=$GATEWAY_VERSION" \
  --set "pump.image.tag=$PUMP_VERSION");

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

setVerbose;
helm upgrade $tykReleaseName "$TYK_HELM_CHART_PATH/$chart" \
  --install \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null;
unsetVerbose;

addSummary "\n\
\tTyk Stack deployed\n \
\tDashboard username: $USERNAME\n \
\tDashboard password: $PASSWORD\n";
