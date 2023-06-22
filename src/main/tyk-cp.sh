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

tykReleaseName="tyk-cp";
addService "dashboard-svc-$tykReleaseName-tyk-dashboard";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
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
  upgradeTyk;

  if ! $dryRun; then
    source src/helpers/up/update-org.sh $tykReleaseName;
  fi
else
  logger "$INFO" "MDCB exists skipping $tykReleaseName install..."
fi

addService "mdcb-svc-$tykReleaseName-tyk-mdcb";
addServiceArgs "mdcb";

mdcbArgs=(--set "mdcb.enabled=true" \
  --set "mdcb.license=$MDCB_LICENSE" \
  --set "mdcb.image.tag=$MDCB_VERSION");

addDeploymentArgs "${mdcbArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${mdcbSecurityContextArgs[@]}";
upgradeTyk;

if ! $dryRun; then
  source src/helpers/up/set-cp-args.sh;
fi

exposeWorker="";
if [[ $NONE != $expose ]]; then
  exposeWorker=" --expose $expose";
fi

addSummary "\tTyk Control Plane deployed\n \
\tDashboard username: $USERNAME\n \
\tDashboard password: $PASSWORD\n \
\tMDCB connection string: $ip:$port\n \
\tOrganisation ID: $orgID\n\n \
You can deploy a worker gateway and connect it to this Control Plane by running the following command:\n\n \
TYK_WORKER_CONNECTIONSTRING=$ip:$port TYK_WORKER_ORGID=$orgID TYK_WORKER_AUTHTOKEN=$authToken TYK_WORKER_USESSL=false ./up.sh --namespace tyk-dp$exposeWorker tyk-dp";
