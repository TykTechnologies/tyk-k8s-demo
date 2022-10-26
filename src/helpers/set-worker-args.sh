port=$(kubectl get service/gateway-svc-$tykReleaseName -n $namespace -o jsonpath="{.spec.ports[0].port}");

ip="localhost";
if [[ $LOADBALANCER == $expose ]]; then
  ip=$(kubectl get service/gateway-svc-$tykReleaseName -n $namespace -o jsonpath="{.status.loadBalancer.ingress[0].ip}");
elif [[ $INGRESS == $expose ]]; then
  ip="TODO";
fi
