mongoReleaseName="tyk-mongo";
checkHelmReleaseExists $mongoReleaseName;

if $releaseExists; then
  logger "$INFO" "$mongoReleaseName release already exists in $namespace namespace...";
else
  logger "$INFO" "installing $mongoReleaseName in namespace $namespace";
fi

setVerbose;
helm upgrade $mongoReleaseName bitnami/mongodb --version 13.6.1 \
  --install \
  -n "$namespace" \
  --set "image.repository=zalbiraw/mongodb" \
  --set "image.tag=4.4.15-debian-10" \
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

