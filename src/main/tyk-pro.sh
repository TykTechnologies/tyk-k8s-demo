source src/main/namespace.sh;
source src/main/redis.sh;
source src/main/storage.sh;

tykArgs=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "pump.image.tag=$TYK_PUMP_VERSION");

tykReleaseName="tyk-pro-tyk-pro";
checkTykRelease;

setVerbose;
helm $command $tykReleaseName $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykStorageArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addService "dashboard-svc-$tykReleaseName";
addService "gateway-svc-$tykReleaseName";
addSummary "\n\
\tTyk Pro deployed\n \
\tDashboard username: default@example.com\n \
\tDashboard password: $PASSWORD\n";

logger $INFO "installed tyk in namespace $namespace";
