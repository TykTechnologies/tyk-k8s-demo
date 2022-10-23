source src/main/namespace.sh;
source src/main/redis.sh;
source src/main/storage.sh;

tykArgs=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "pump.image.tag=$TYK_PUMP_VERSION");

tykReleaseName="tyk-cp-tyk-pro";
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

echo $dryRun

if ! $dryRun; then
  source src/helpers/update-hybrid-org.sh $tykReleaseName;
fi

mdcbArgs=(--set "mdcb.enabled=true" \
  --set "mdcb.license=$MDCB_LICENSE" \
  --set "mdcb.service.type=NodePort" \
  --set "mdcb.image.tag=$TYK_MDCB_VERSION");

setVerbose;
helm upgrade $tykReleaseName $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykStorageArgs[@]}" \
  "${mdcbArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  "${mdcbSecurityContextArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addService "dashboard-svc-$tykReleaseName";
addService "gateway-svc-$tykReleaseName";
addService "mdcb-svc-$tykReleaseName";

addSummary "\n\
\tTyk Control Plane deployed\n \
\tDashboard username: default@example.com\n \
\tDashboard password: $PASSWORD\n \
\tMDCB connection string: \n \
\tOrganisation ID: $orgID \n \
\n\n You deploy a hybrid gateway and connect it to this Control Plane by running the following command: \n\n \
\tTYK_HYBRID_CONNECTIONSTRING=$test TYK_HYBRID_ORGID=$test TYK_HYBRID_AUTHTOKEN=$test ./up.sh tyk-hybrid\n";

logger $INFO "installed tyk in namespace $namespace";
