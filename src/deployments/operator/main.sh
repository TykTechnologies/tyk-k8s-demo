source src/deployments/operator/helpers.sh;

logger "$INFO" "installing tyk-operator...";

checkOperatorSecretExists;
if ! $operatorSecretExists; then
  logger "$INFO" "you need an operator secret to install the operator with a worker gateway";
  exit 1;
fi

operatorReleaseName="tyk-operator";
certManagerReleaseName="tyk-operator-cert-manager";

setVerbose;
helm upgrade "$certManagerReleaseName" jetstack/cert-manager \
  --install \
  --version v1.10.1 \
  --namespace "$namespace" \
  --wait --debug;

helm upgrade $operatorReleaseName tyk-helm/tyk-operator \
  --install \
  --namespace "$namespace" \
  --wait > /dev/null;
unsetVerbose;

logger "$INFO" "installed tyk-operator in namespace $namespace";
