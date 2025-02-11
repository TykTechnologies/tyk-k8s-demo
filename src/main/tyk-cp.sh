source src/main/storage/main.sh;

tykReleaseName="tyk-cp";
tykReleaseVersion="2.2.0";

args=(
  --set "global.license.dashboard=$LICENSE" \
  --set "global.license.operator=$OPERATOR_LICENSE" \
  --set "global.adminUser.email=$TYK_USERNAME" \
  --set "global.adminUser.password=$TYK_PASSWORD" \
  --set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-dashboard.dashboard.image.tag=$DASHBOARD_VERSION" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub" \
  --set "tyk-pump.pump.image.tag=$PUMP_VERSION" \
  --set "tyk-mdcb.mdcb.license=$MDCB_LICENSE" \
  --set "tyk-mdcb.mdcb.image.tag=$MDCB_VERSION" \
  --set "tyk-mdcb.mdcb.service.type=NodePort" \
  --set "tyk-dashboard.tib.enabled=true" \
);

addService "dashboard-svc-$tykReleaseName-tyk-dashboard";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
addService "mdcb-svc-$tykReleaseName-tyk-mdcb";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${mdcbSecurityContextArgs[@]}";
addDeploymentArgs "${loadbalancerArgs[@]}";
addDeploymentArgs "${ingressArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
upgradeTyk;

exposeWorker="";
if [[ $NONE != $expose ]]; then
  exposeWorker=" --expose $expose";
fi

source src/helpers/up/set-cp-args.sh;

addSummary "\tTyk Control Plane deployed\n \
\tDashboard username: $TYK_USERNAME\n \
\tDashboard password: $TYK_PASSWORD\n \
\tMDCB connection string: $ip:$port\n \
\tOrganisation ID: $orgID\n\n \
You can deploy a worker gateway and connect it to this Control Plane by running the following command:\n\n \
TYK_DATA_PLANE_CONNECTIONSTRING=$ip:$port TYK_DATA_PLANE_ORGID=$orgID TYK_DATA_PLANE_AUTHTOKEN=$authToken TYK_DATA_PLANE_USESSL=false ./up.sh --namespace tyk-dp$exposeWorker tyk-dp";
