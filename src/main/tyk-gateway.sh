source src/main/namespace.sh;
source src/main/redis/main.sh;

args=(--set "gateway.image.tag=$GATEWAY_VERSION" \
  --set "gateway.image.repository=tykio/tyk-gateway" \
  --set "gateway.kind=Deployment" \
  --set "gateway.service.port=8080" \
  --set "pump.enabled=true" \
  --set "pump.image.repository=tykio/tyk-pump-docker-pub");

tykReleaseName="tyk-gateway";
addService "gateway-svc-$tykReleaseName-$chart";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
upgradeTyk;

kubectl create secret generic tyk-operator-conf \
  --from-literal="TYK_MODE=ce" \
  --from-literal="TYK_URL=http://gateway-svc-$tykReleaseName-$chart.$namespace.svc:8080" \
  --from-literal="TYK_AUTH=$(kubectl get secrets -n "$namespace" "secrets-$tykReleaseName-$chart" -o jsonpath="{.data.APISecret}" | base64 -d)" \
  --from-literal="TYK_ORG=tyk" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addSummary "\tTyk Gateway deployed";
