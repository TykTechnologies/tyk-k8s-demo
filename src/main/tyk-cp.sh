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

tykReleaseName="tyk-cp-tyk-pro";
addService "dashboard-svc-$tykReleaseName";
addService "gateway-svc-$tykReleaseName";
addServiceArgs "dash";
addServiceArgs "gateway";
checkTykRelease;
checkMDCBRelease;

if ! $mdcbExists; then
  setVerbose;
  helm $command $tykReleaseName $TYK_HELM_CHART_PATH/$chart \
    -n $namespace \
    "${deploymentsArgs[@]}" \
    --atomic \
    --wait > /dev/null;
  unsetVerbose;

  if ! $dryRun; then
    source src/helpers/update-org.sh $tykReleaseName;
  fi
else
  logger $INFO "MDCB exists skipping $tykReleaseName install..."
fi


addService "mdcb-svc-$tykReleaseName";
addServiceArgs "mdcb";

mdcbArgs=(--set "mdcb.enabled=true" \
  --set "mdcb.license=$MDCB_LICENSE" \
  --set "mdcb.image.tag=$TYK_MDCB_VERSION");

addDeploymentArgs "${mdcbArgs[@]}";
addDeploymentArgs "${mdcbSecurityContextArgs[@]}";

setVerbose;
helm upgrade $tykReleaseName $TYK_HELM_CHART_PATH/$chart \
  -n $namespace \
  "${deploymentsArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

if ! $dryRun; then
  source src/helpers/set-cp-args.sh;
fi

exposeWorker="";
if [[ $NONE != $expose ]]; then
  exposeWorker=" --expose $expose";
fi

addSummary "\n\
\tTyk Control Plane deployed\n \
\tDashboard username: default@example.com\n \
\tDashboard password: $PASSWORD\n \
\tMDCB connection string: $ip:$port\n \
\tOrganisation ID: $orgID\n";

addSummary "\n\
You deploy a worker gateway and connect it to this Control Plane by running the following command: \n\n \
\tTYK_WORKER_CONNECTIONSTRING=$ip:$port TYK_WORKER_ORGID=$orgID TYK_WORKER_AUTHTOKEN=$authToken TYK_WORKER_USESSL=false ./up.sh --namespace tyk-worker$exposeWorker tyk-worker\n";

logger $INFO "installed tyk in namespace $namespace";
