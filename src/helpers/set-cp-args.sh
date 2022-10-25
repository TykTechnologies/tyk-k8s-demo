authToken=$(kubectl get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_AUTH}' | base64 -d);
port=$(kubectl get service/mdcb-svc-$tykReleaseName -n $namespace -o jsonpath="{.spec.ports[0].port}");

ip="mdcb-svc-$tykReleaseName.$namespace.svc";
if [[ $LOADBALANCER == $expose ]]; then
  ip=$(kubectl get service/mdcb-svc-$tykReleaseName -n $namespace -o jsonpath="{.status.loadBalancer.ingress[0].ip}");
elif [[ $INGRESS == $expose ]]; then
  ip="TODO";
fi
