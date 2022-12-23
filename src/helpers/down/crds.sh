set +e;
policies=$(kubectl get tykpolicies -n "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
apis=$(kubectl get tykapis -n "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
supergraphs=$(kubectl get supergraphs -n "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');
subgraphs=$(kubectl get subgraphs -n "$namespace"  2> /dev/null |  awk '{print $1}' | tail -n +2 | tr '\n' ' ');

kubectl delete -n "$namespace" tykpolicies $policies &> /dev/null;
kubectl delete -n "$namespace" tykapis $apis &> /dev/null;
kubectl delete -n "$namespace" supergraphs $supergraphs &> /dev/null;
kubectl delete -n "$namespace" subgraphs $subgraphs &> /dev/null;
set -e;
