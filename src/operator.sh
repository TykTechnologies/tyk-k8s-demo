source src/helpers/operator-exists.sh

if $operatorExists; then
  echo "Warning: tyk-operator release already exists...skipping Tyk Operator install."
else
  set -x
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
  sleep 1
  helm install tyk-operator tyk-helm/tyk-operator -n $namespace
  set +x
fi
