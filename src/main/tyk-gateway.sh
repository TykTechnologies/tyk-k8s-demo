source src/main/namespace.sh;
source src/main/redis.sh;

args=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.image.repository=tykio/tyk-gateway" \
  --set "gateway.kind=Deployment" \
  --set "gateway.service.port=8080");

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";

tykReleaseName="tyk-gateway-tyk-headless";
addService "gateway-svc-$tykReleaseName";
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
\tTyk Gateway deployed\n";

logger $INFO "installed tyk in namespace $namespace";
