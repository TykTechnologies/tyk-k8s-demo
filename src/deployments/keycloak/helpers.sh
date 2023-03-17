waitForKeycloakPods() {
  logger "$DEBUG" "keycloak/helpers.sh: waiting for pods to start...";

  while : ; do
    sleep 1;

    set +e;
    search=$(kubectl get --namespace "$namespace" pods "$keycloakName-0" 2> /dev/null | grep "$keycloakName-0");
    logger "$DEBUG" "pod $keycloakName-0 not found";
    set -e;

    if ! [[ -z $search ]]; then
      break;
    fi
  done
}
