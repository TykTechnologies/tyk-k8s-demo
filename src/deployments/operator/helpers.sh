checkOperatorSecretExists() {
  set +e;
  search=$(kubectl get secrets -n "$namespace" | grep "tyk-operator-conf");
  logger "$DEBUG" "checkOperatorSecretExists: search result $search";
  set -e;

  operatorSecretExists=true;
  if [[ -z $search ]]; then
    operatorSecretExists=false;
  fi
}
