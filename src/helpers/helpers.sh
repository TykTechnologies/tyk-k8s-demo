checkHelmReleaseExists() {
  set +e;
  search=$(helm ls --namespace "$namespace" | awk '{print $1}' | grep -e "^$1$");
  logger "$DEBUG" "checkHelmReleaseExists: search result $search";
  set -e;

  releaseExists=true;
  if [[ -z $search ]]; then
    releaseExists=false;
  fi
}

checkHelmReleaseExistsAllNamespaces() {
  set +e;
  search=$(helm ls --all-namespaces | awk '{print $1}' | grep -e "^$1$");
  logger "$DEBUG" "checkHelmReleaseExists: search result $search";
  set -e;

  releaseExists=true;
  if [[ -z $search ]]; then
    releaseExists=false;
  fi
}

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
