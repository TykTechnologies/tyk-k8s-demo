authToken=$(kubectl get secrets tyk-operator-conf --namespace "$namespace" -o=jsonpath='{.data.TYK_AUTH}' | base64 -d);
orgID=$(kubectl get secrets tyk-operator-conf --namespace "$namespace" -o=jsonpath='{.data.TYK_ORG}' | base64 -d);
port=$(kubectl get "service/mdcb-svc-$tykReleaseName-$chart" --namespace "$namespace" -o jsonpath="{.spec.ports[0].port}");

ip="mdcb-svc-$tykReleaseName-$chart.$namespace.svc";
if [[ $LOADBALANCER == "$expose" ]]; then
  ip=$(kubectl get "service/mdcb-svc-$tykReleaseName-$chart" --namespace "$namespace" -o jsonpath="{.status.loadBalancer.ingress[0].ip}");
elif [[ $INGRESS == "$expose" ]]; then
  ip="TODO";
fi
