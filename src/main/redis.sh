tykRedisArgs=();
redisReleaseName="tyk-redis";
checkHelmReleaseExists $redisReleaseName;

if [[ $REDISCLUSTER == $redis ]]; then
  args=(--set "redis.addrs[0]=$redisReleaseName-redis-cluster.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD" \
    --set "redis.enableCluster=true");
elif [[ $REDISSENTINEL == $redis ]]; then
  args=(--set "redis.addrs[0]=$redisReleaseName.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD");
else
  args=(--set "redis.addrs[0]=$redisReleaseName-master.$namespace.svc:6379" \
    --set "redis.pass=$PASSWORD");
fi

if $releaseExists; then
  logger $INFO "$redisReleaseName release already exists in $namespace namespace...skipping Redis install";
else
  logger $INFO "installing $redisReleaseName in namespace $namespace";
  if [[ $REDISCLUSTER == $redis ]]; then
    setVerbose;
    helm install $redisReleaseName bitnami/redis-cluster --version 7.6.4 \
      -n $namespace \
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
      "${redisSecurityContextArgs[@]}" \
      --atomic \
      --wait > /dev/null;
    unsetVerbose;
  elif [[ $REDISSENTINEL == $redis ]]; then
    setVerbose;
    helm install $redisReleaseName bitnami/redis --version 17.3.2 \
      -n $namespace \
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
      "${redisSecurityContextArgs[@]}" \
      --atomic \
      --wait > /dev/null;
    unsetVerbose;
  else
    setVerbose;
    helm install $redisReleaseName bitnami/redis --version 17.3.2 \
      -n $namespace \
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
      "${redisSecurityContextArgs[@]}" \
      --atomic \
      --wait > /dev/null;
    unsetVerbose;
  fi
  logger $INFO "installed $redisReleaseName in namespace $namespace";
fi

addDeploymentArgs "${args[@]}";
