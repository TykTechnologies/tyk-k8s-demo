checkTykRelease() {
  checkHelmReleaseExists "$tykReleaseName";

  if $releaseExists; then
    logger "$INFO" "$tykReleaseName release already exists in $namespace namespace...";
  else
    logger "$INFO" "installing tyk in $namespace namespace";
  fi
}
