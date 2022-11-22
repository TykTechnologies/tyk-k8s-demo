source src/main/namespace.sh;
source src/main/redis.sh;
source src/main/storage.sh;

args=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "pump.image.tag=$TYK_PUMP_VERSION");

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";

tykReleaseName="tyk-pro-tyk-pro";
addService "dashboard-svc-$tykReleaseName";
addService "gateway-svc-$tykReleaseName";
addServiceArgs "dash";
addServiceArgs "gateway";
checkTykRelease;

setVerbose;
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/$chart \
  -n $namespace \
  "${deploymentsArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addSummary "\n\
\tTyk Pro deployed\n \
\tDashboard username: default@example.com\n \
\tDashboard password: $PASSWORD\n";

logger $INFO "installed tyk in namespace $namespace";
