mongoReleaseName="tyk-mongo";
checkHelmReleaseExists $mongoReleaseName;

addService "$mongoReleaseName-mongodb";

if $releaseExists; then
  logger $INFO "$mongoReleaseName release already exists in $namespace namespace...skipping $mongoReleaseName install";
else
  logger $INFO "installing $mongoReleaseName in $namespace";
  setVerbose;
  helm install $mongoReleaseName bitnami/mongodb --version 11.1.10 \
    -n $namespace \
    --set "auth.rootPassword=$PASSWORD" \
    --set "replicaSet.enabled=true" \
    "${mongoSecurityContextArgs[@]}" \
    --atomic \
    --wait > /dev/null;
  unsetVerbose;
  logger $INFO "installed $mongoReleaseName in $namespace";
fi
