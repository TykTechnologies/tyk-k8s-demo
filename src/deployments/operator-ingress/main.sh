logger $DEBUG "Creating Tyk Operator as Ingress example...";

loadBalancerArgs=(--set "gateway.service.type=LoadBalancer");
addDeploymentArgs "${loadBalancerArgs[@]}";

helm upgrade $tykReleaseName $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykStorageArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  "${deploymentsArgs[@]}" \
  --wait

set -x
kubectl apply -f src/deployments/operator-ingress/httpbin-deployment.yaml -n $namespace
kubectl apply -f src/deployments/operator-ingress/http-ingress.yaml -n $namespace
set +x
