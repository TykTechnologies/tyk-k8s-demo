source src/main/namespace.sh;
source src/main/redis.sh;
source src/main/storage.sh;

args=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.email=$USERNAME" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "pump.image.tag=$TYK_PUMP_VERSION");

tykReleaseName="tyk-stack";
addService "dashboard-svc-$tykReleaseName";
addService "gateway-svc-$tykReleaseName";
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
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addSummary "\n\
\tTyk Pro deployed\n \
\tDashboard username: $USERNAME\n \
\tDashboard password: $PASSWORD\n";

logger "$INFO" "installed tyk in namespace $namespace";
