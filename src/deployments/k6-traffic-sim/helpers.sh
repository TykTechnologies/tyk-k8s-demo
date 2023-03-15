checkK6OperatorExists() {
  set +e;
  search=$(kubectl get pods -n k6-operator-system 2> /dev/null | awk '{print $1}' | grep -e "^k6-operator-controller-manager-");
  logger "$DEBUG" "k6-operator-exists: search result: $search";
  set -e;

  if [[ -z $search ]]; then
    k6OperatorExists=false;
  else
    k6OperatorExists=true;
  fi
}

waitForK6Jobs() {
  logger "$INFO" "waiting for jobs to start...";

  while : ; do
    sleep 1;

    set +e;
    search=$(kubectl get --namespace "$namespace" jobs "$test_name-1" 2> /dev/null | grep "$test_name-1");
    logger "$DEBUG" "job $test_name-1 not found";
    set -e;

    if ! [[ -z $search ]]; then
      break;
    fi
  done
}
