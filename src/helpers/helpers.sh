waitForPods() {
  logger "$DEBUG" "helpers.sh: waiting for pods to start...";

  while : ; do
    sleep 1;

    set +e;
    search=$(kubectl get --namespace "$namespace" pods -l "$1" 2> /dev/null | grep "$2");
    set -e;

    if ! [[ -z $search ]]; then
      break;
    fi

    logger "$DEBUG" "pod $1 not found";
  done
}

terminateDashboardPort() {
  set +e;
  pid=$(pgrep -f "svc/dashboard-svc-$tykReleaseName-$chart");
  set -e;

  if [[ -n "$pid" ]]; then
    logger "$DEBUG" "terminating dashboard port-forwarding ($pid)";
    kill -9 "$pid" 2>&1;
  fi
}
