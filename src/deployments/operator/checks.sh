checkOperatorSecretExists() {
  set +e;
  search=$(kubectl get secrets --namespace "$namespace" | grep "tyk-operator-conf");
  logger "$DEBUG" "checkOperatorSecretExists: search result $search";
  set -e;

  operatorSecretExists=true;
  if [[ -z $search ]]; then
    operatorSecretExists=false;
  fi
}

checkOperatorSecretExists;
if ! $operatorSecretExists; then
  logger "$INFO" "you need an operator secret to install the operator with a worker gateway";
  exit 1;
fi
