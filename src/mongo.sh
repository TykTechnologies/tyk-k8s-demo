mongoReleaseName="tyk-mongo";
checkHelmReleaseExists $mongoReleaseName;

addService "$mongoReleaseName-mongodb";

if $releaseExists; then
  logger $INFO "$mongoReleaseName release already exists in $namespace namespace...skipping $mongoReleaseName install";
else
  set -x
  helm install $mongoReleaseName bitnami/mongodb --version 11.1.10 \
    -n $namespace \
    --set "auth.rootPassword=$PASSWORD" \
    --set "replicaSet.enabled=true" \
    "${mongoSecurityContextArgs[@]}" \
    --wait
  set +x
fi
