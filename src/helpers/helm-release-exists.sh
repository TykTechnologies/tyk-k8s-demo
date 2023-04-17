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
