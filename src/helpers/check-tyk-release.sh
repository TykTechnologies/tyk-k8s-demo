checkTykRelease() {
  command="install";
  checkHelmReleaseExists $tykReleaseName;

  if $releaseExists; then
    command="upgrade";
    logger $INFO "$tykReleaseName release already exists in $namespace namespace...attempting to upgrade";
  else
    logger $INFO "installing tyk in namespace $namespace";
  fi
}
