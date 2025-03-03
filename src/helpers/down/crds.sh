set +e;
tykpolicies=$(kubectl get tykpolicies --namespace "$namespace" 2> /dev/null | awk '{print $1}' | tail -n +2 | tr '\n' ' ');
tykapis=$(kubectl get tykapis --namespace "$namespace" 2> /dev/null | awk '{print $1}' | tail -n +2 | tr '\n' ' ');
tykoas=$(kubectl get tykoas --namespace "$namespace" 2> /dev/null | awk '{print $1}' | tail -n +2 | tr '\n' ' ');
tykstreams=$(kubectl get tykstreams --namespace "$namespace" 2> /dev/null | awk '{print $1}' | tail -n +2 | tr '\n' ' ');
supergraphs=$(kubectl get supergraphs --namespace "$namespace" 2> /dev/null | awk '{print $1}' | tail -n +2 | tr '\n' ' ');
subgraphs=$(kubectl get subgraphs --namespace "$namespace" 2> /dev/null | awk '{print $1}' | tail -n +2 | tr '\n' ' ');

setVerbose;
kubectl delete --namespace "$namespace" tykpolicies $tykpolicies &> /dev/null;
kubectl delete --namespace "$namespace" tykapis $tykapis &> /dev/null;
kubectl delete --namespace "$namespace" tykoas $tykoas &> /dev/null;
kubectl delete --namespace "$namespace" tykstreams $tykstreams &> /dev/null;
kubectl delete --namespace "$namespace" supergraphs $supergraphs &> /dev/null;
kubectl delete --namespace "$namespace" subgraphs $subgraphs &> /dev/null;
unsetVerbose;
set -e;
