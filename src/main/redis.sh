redisReleaseName="tyk-redis";

logger "$INFO" "installing $redisReleaseName in $namespace namespace";

tykRedisArgs=();
if [[ $REDISCLUSTER == "$redis" ]]; then
  logger "$DEBUG" "redis.sh: setting tyk related redis cluster configuration";
  args=(--set "redis.addrs[0]=$redisReleaseName-redis-cluster.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD" \
    --set "redis.enableCluster=true");
elif [[ $REDISSENTINEL == "$redis" ]]; then
  logger "$DEBUG" "redis.sh: setting tyk related redis sentinel configuration";
  args=(--set "redis.addrs[0]=$redisReleaseName.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD");
else
  logger "$DEBUG" "redis.sh: setting tyk related redis configuration";
  args=(--set "redis.addrs[0]=$redisReleaseName-master.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD");
fi

securityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  if [[ $REDISCLUSTER == "$redis" ]]; then
    logger "$DEBUG" "redis.sh: setting openshift related redis cluster configuration";
    securityContextArgs=(--set "podSecurityContext.runAsUser=$OS_UID_RANGE" \
      --set "podSecurityContext.fsGroup=$OS_UID_RANGE" \
      --set "containerSecurityContext.runAsUser=$OS_UID_RANGE");
  elif [[ $REDISSENTINEL == "$redis" ]]; then
    logger "$DEBUG" "redis.sh: setting openshift related redis sentinel configuration";
    securityContextArgs=(--set "replica.podSecurityContext.fsGroup=$OS_UID_RANGE" \
      --set "replica.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
      --set "sentinel.containerSecurityContext.runAsUser=$OS_UID_RANGE");
  else
    logger "$DEBUG" "redis.sh: setting openshift related redis configuration";
    securityContextArgs=(--set "master.podSecurityContext.fsGroup=$OS_UID_RANGE" \
      --set "master.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
      --set "replica.podSecurityContext.fsGroup=$OS_UID_RANGE" \
      --set "replica.containerSecurityContext.runAsUser=$OS_UID_RANGE");
  fi
fi

addDeploymentArgs "${args[@]}";
if [[ $REDISCLUSTER == "$redis" ]]; then
  setVerbose;
  helm upgrade $redisReleaseName bitnami/redis-cluster --version 7.6.4 \
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
    "$helmFlags" > /dev/null;
  unsetVerbose;
elif [[ $REDISSENTINEL == "$redis" ]]; then
  setVerbose;
  helm upgrade $redisReleaseName bitnami/redis --version 17.3.2 \
    --install \
    --namespace "$namespace" \
    --set "image.repository=zalbiraw/redis" \
    --set "image.tag=6.2.7-debian-11" \
    \
    --set "sentinel.image.repository=zalbiraw/redis-sentinel" \
    --set "sentinel.image.tag=6.2.7-debian-11" \
    \
    --set "metrics.image.repository=zalbiraw/redis-exporter" \
    --set "metrics.image.tag=1.45.0-debian-11" \
    \
    --set "volumePermissions.image.repository=zalbiraw/bitnami-shell" \
    --set "volumePermissions.image.tag=11.0.0-debian-11" \
    \
    --set "sysctl.image.repository=zalbiraw/bitnami-shell" \
    --set "sysctl.image.tag=11.0.0-debian-11" \
    \
    --set "auth.password=$PASSWORD" \
    --set "sentinel.enabled=true" \
    "${securityContextArgs[@]}" \
    "$helmFlags" > /dev/null;
  unsetVerbose;
else
  setVerbose;
  helm upgrade $redisReleaseName bitnami/redis --version 17.3.2 \
    --install \
    --namespace "$namespace" \
    --set "image.repository=zalbiraw/redis" \
    --set "image.tag=6.2.7-debian-11" \
    \
    --set "sentinel.image.repository=zalbiraw/redis-sentinel" \
    --set "sentinel.image.tag=6.2.7-debian-11" \
    \
    --set "metrics.image.repository=zalbiraw/redis-exporter" \
    --set "metrics.image.tag=1.45.0-debian-11" \
    \
    --set "volumePermissions.image.repository=zalbiraw/bitnami-shell" \
    --set "volumePermissions.image.tag=11.0.0-debian-11" \
    \
    --set "sysctl.image.repository=zalbiraw/bitnami-shell" \
    --set "sysctl.image.tag=11.0.0-debian-11" \
    \
    --set "auth.password=$PASSWORD" \
    "${securityContextArgs[@]}" \
    "$helmFlags" > /dev/null;
  unsetVerbose;
fi
