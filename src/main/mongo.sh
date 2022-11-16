mongoReleaseName="tyk-mongo";
checkHelmReleaseExists $mongoReleaseName;

if $releaseExists; then
  logger $INFO "$mongoReleaseName release already exists in $namespace namespace...skipping $mongoReleaseName install";
else
  logger $INFO "installing $mongoReleaseName in namespace $namespace";
  setVerbose;
  helm install $mongoReleaseName bitnami/mongodb --version 11.1.10 \
    -n $namespace \
    --set "image.repository=zalbiraw/mongodb" \
    --set "image.tag=5.0.13-debian-11" \
    \
    --set "volumePermissions.image.repository=zalbiraw/bitnami-shell" \
    --set "volumePermissions.image.tag=11.0.0-debian-11" \
    \
    --set "metrics.image.repository=zalbiraw/mongodb-exporter" \
    --set "metrics.image.tag=0.35.0-debian-11" \
    \
    --set "tls.image.repository=zalbiraw/nginx" \
    --set "tls.image.tag=1.23.2-debian-11" \
    \
    --set "externalAccess.autoDiscovery.image.repository=zalbiraw/kubectl" \
    --set "externalAccess.autoDiscovery.image.tag=1.25.3-debian-11" \
    \
    --set "auth.rootPassword=$PASSWORD" \
    --set "replicaSet.enabled=true" \
    "${mongoSecurityContextArgs[@]}" \
    --atomic \
    --wait > /dev/null;
  unsetVerbose;
  logger $INFO "installed $mongoReleaseName in namespace $namespace";
fi
