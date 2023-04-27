logger "$DEBUG" "redis-cluster.sh: setting tyk related redis cluster configuration";
args=(--set "redis.addrs[0]=$redisReleaseName-redis-cluster.$namespace.svc:6379" \
  --set "redis.pass=$PASSWORD" \
  --set "redis.enableCluster=true");

if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$DEBUG" "redis-cluster.sh: setting openshift related redis cluster configuration";
  securityContextArgs=(--set "podSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "podSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "containerSecurityContext.seccompProfile.type=RuntimeDefault");
fi

addDeploymentArgs "${args[@]}";
setVerbose;
helm upgrade "$redisReleaseName" bitnami/redis-cluster --version 7.6.4 \
  --install \
  --namespace "$namespace" \
  --set "image.repository=zalbiraw/redis-cluster" \
  --set "image.tag=6.2.7-debian-11" \
  \
  --set "metrics.image.repository=zalbiraw/redis-exporter" \
  --set "metrics.image.tag=1.45.0-debian-11" \
  \
  --set "volumePermissions.image.repository=zalbiraw/bitnami-shell" \
  --set "volumePermissions.image.tag=11.0.0-debian-11" \
  \
  --set "sysctlImage.repository=zalbiraw/bitnami-shell" \
  --set "sysctlImage.tag=11.0.0-debian-11" \
  \
  --set "password=$PASSWORD" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
