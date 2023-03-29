source src/main/namespace.sh;
source src/main/redis.sh;
source src/main/storage.sh;

args=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.email=$USERNAME" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$DASHBOARD_VERSION" \
  --set "gateway.image.tag=$GATEWAY_VERSION" \
  --set "pump.image.tag=$PUMP_VERSION");

tykReleaseName="tyk-cp";
addService "dashboard-svc-$tykReleaseName-$chart";
addService "gateway-svc-$tykReleaseName-$chart";
addServiceArgs "dash";
addServiceArgs "gateway";
checkTykRelease;
checkMDCBRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";

if ! $mdcbExists; then
  setVerbose;
  helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
    --install \
    --namespace "$namespace" \
    "${deploymentsArgs[@]}" \
    --wait --atomic > /dev/null;
  unsetVerbose;

  if ! $dryRun; then
    source src/helpers/up/update-org.sh $tykReleaseName;
  fi
else
  logger "$INFO" "MDCB exists skipping $tykReleaseName install..."
fi

addService "mdcb-svc-$tykReleaseName-$chart";
addServiceArgs "mdcb";

mdcbArgs=(--set "mdcb.enabled=true" \
  --set "mdcb.license=$MDCB_LICENSE" \
  --set "mdcb.image.tag=$MDCB_VERSION");

addDeploymentArgs "${mdcbArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${mdcbSecurityContextArgs[@]}";

setVerbose;
helm upgrade $tykReleaseName "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null;
unsetVerbose;

if ! $dryRun; then
  source src/helpers/up/set-cp-args.sh;
fi

exposeWorker="";
if [[ $NONE != $expose ]]; then
  exposeWorker=" --expose $expose";
fi

addSummary "\n\
\tTyk Control Plane deployed\n \
\tDashboard username: $USERNAME\n \
\tDashboard password: $PASSWORD\n \
\tMDCB connection string: $ip:$port\n \
\tOrganisation ID: $orgID\n";

addSummary "\n\
You deploy a worker gateway and connect it to this Control Plane by running the following command: \n\n \
\tTYK_WORKER_CONNECTIONSTRING=$ip:$port TYK_WORKER_ORGID=$orgID TYK_WORKER_AUTHTOKEN=$authToken TYK_WORKER_USESSL=false ./up.sh --namespace tyk-dp$exposeWorker tyk-dp\n";
