checkTykRelease() {
  checkHelmReleaseExists "$tykReleaseName";

  if $releaseExists; then
    logger "$INFO" "$tykReleaseName release already exists in $namespace namespace...attempting to upgrade";
  else
    logger "$INFO" "installing tyk in namespace $namespace";
  fi
}

checkMDCBRelease() {
  set +e;
  search=$(kubectl get svc --namespace "$namespace" | awk '{print $1}' | grep -e "^mdcb-");
  logger "$DEBUG" "mdcb-exists: search result: $search";
  set -e;

  if [[ -z $search ]]; then
    mdcbExists=false;
  else
    mdcbExists=true;
  fi
}
