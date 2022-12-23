source src/main/namespace.sh;
source src/main/redis.sh;

args=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.image.repository=tykio/tyk-gateway" \
  --set "gateway.kind=Deployment" \
  --set "gateway.service.port=8080");

tykReleaseName="tyk-gateway-tyk-headless";
addService "gateway-svc-$tykReleaseName";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";

setVerbose;
helm upgrade $tykReleaseName "$TYK_HELM_CHART_PATH/$chart" \
  --install \
  -n "$namespace" \
  "${deploymentsArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;

addSummary "\n\
\tTyk Gateway deployed\n";

logger "$INFO" "installed tyk in namespace $namespace";
