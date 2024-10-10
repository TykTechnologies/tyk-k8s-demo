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

if [[ $TYKSTACK != "$mode" ]] && [[ $TYKCP != "$mode" ]] && [[ $TYKDP != "$mode" ]]; then
  logger "$ERROR" "can only install the operator with a tyk-stack, a tyk-cp, or a tyk-dp installation";
  exit 1;
fi

if [[ -z "$OPERATOR_LICENSE" ]]; then
  logger "$ERROR" "Please make sure the OPERATOR_LICENSE variable is set in your .env file";
  exit 1;
else
  checkLicense "$OPERATOR_LICENSE"
  if $expired; then
    logger "$ERROR" "Your Operator license has expired or is invalid. Please provide another license key";
    exit 1;
  fi
fi
