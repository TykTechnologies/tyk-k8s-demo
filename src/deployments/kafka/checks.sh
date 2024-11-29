if [[ $TYKGATEWAY == "$mode" ]]; then
  logger "$ERROR" "can only run the kafka example with a tyk-stack, tyk-dp or a tyk-cp installations";
  exit 1;
fi
