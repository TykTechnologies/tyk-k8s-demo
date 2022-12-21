source src/deployments/operator/helpers.sh;

logger "$INFO" "installing tyk-operator...";

checkOperatorSecretExists;
if ! $operatorSecretExists; then
  logger "$INFO" "you need an operator secret to install the operator with a worker gateway";
  exit 1;
fi

operatorReleaseName="tyk-operator";

setVerbose;
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.8.0/cert-manager.yaml > /dev/null;
kubectl wait -n cert-manager deployment.apps/cert-manager-webhook --for condition=Available=True --timeout=90s > /dev/null;

helm upgrade $operatorReleaseName tyk-helm/tyk-operator \
  --install \
  -n "$namespace" \
   --wait > /dev/null;
unsetVerbose;

logger "$INFO" "installed tyk-operator in namespace $namespace";
