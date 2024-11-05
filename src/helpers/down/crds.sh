set +e;
policies=$(kubectl get tykpolicies --namespace "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
apis=$(kubectl get tykapis --namespace "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
oasapis=$(kubectl get tykoas --namespace "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
supergraphs=$(kubectl get supergraphs --namespace "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
subgraphs=$(kubectl get subgraphs --namespace "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');

kubectl delete --namespace "$namespace" tykpolicies $policies &> /dev/null;
kubectl delete --namespace "$namespace" tykapis $apis &> /dev/null;
kubectl delete --namespace "$namespace" tykoas $oasapis &> /dev/null;
kubectl delete --namespace "$namespace" supergraphs $supergraphs &> /dev/null;
kubectl delete --namespace "$namespace" subgraphs $subgraphs &> /dev/null;
set -e;
