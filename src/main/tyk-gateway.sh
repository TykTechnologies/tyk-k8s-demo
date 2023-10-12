args=(--set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-pump.pump.backend[0]=" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub");

tykReleaseName="tyk-oss";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
addDeploymentArgs "${loadbalancerArgs[@]}";
addDeploymentArgs "${ingressArgs[@]}";
upgradeTyk;

kubectl create secret generic tyk-operator-conf \
  --from-literal="TYK_MODE=ce" \
  --from-literal="TYK_URL=http://gateway-svc-$tykReleaseName-tyk-gateway.$namespace.svc:8080" \
  --from-literal="TYK_AUTH=$(kubectl get secrets -n "$namespace" "secrets-$tykReleaseName-tyk-gateway" -o jsonpath="{.data.APISecret}" | base64 -d)" \
  --from-literal="TYK_ORG=tyk" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addSummary "\tTyk Gateway deployed";
