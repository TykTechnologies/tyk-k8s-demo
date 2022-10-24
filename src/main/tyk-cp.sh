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

if ! $dryRun; then
  source src/helpers/update-hybrid-org.sh $tykReleaseName;
fi

addService "dashboard-svc-$tykReleaseName";
addService "gateway-svc-$tykReleaseName";

serviceType="LoadBalancer";
if ! $TYK_CP_RUNASLB; then
  serviceType="NodePort";
  addService "mdcb-svc-$tykReleaseName";
fi

mdcbArgs=(--set "mdcb.enabled=true" \
  --set "mdcb.license=$MDCB_LICENSE" \
  --set "mdcb.service.type=$serviceType" \
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

if ! $dryRun; then
  source src/helpers/set-cp-args.sh;
fi

addSummary "\n\
\tTyk Control Plane deployed\n \
\tDashboard username: default@example.com\n \
\tDashboard password: $PASSWORD\n \
\tMDCB connection string: $ip:$port\n \
\tOrganisation ID: $orgID\n";

if $TYK_CP_RUNASLB; then
addSummary "\n\
You deploy a hybrid gateway and connect it to this Control Plane by running the following command: \n\n \
\tTYK_HYBRID_CONNECTIONSTRING=$ip:$port TYK_HYBRID_ORGID=$orgID TYK_HYBRID_AUTHTOKEN=$authToken ./up.sh tyk-hybrid\n";
else
addSummary "\n\
You deploy a hybrid gateway and connect it to this Control Plane by running the following command: \n\n \
\tTYK_HYBRID_CONNECTIONSTRING=$ip:$port TYK_HYBRID_ORGID=$orgID TYK_HYBRID_AUTHTOKEN=$authToken TYK_HYBRID_USESSL=false ./up.sh --namespace tyk-hybrid tyk-hybrid\n";
fi

logger $INFO "installed tyk in namespace $namespace";
