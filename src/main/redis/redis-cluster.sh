logger "$DEBUG" "redis-cluster.sh: setting tyk related redis cluster configuration";
args=(
  --set "global.redis.addrs[0]=$redisReleaseName-redis-cluster.$namespace.svc:6379" \
  --set "global.redis.pass=$TYK_PASSWORD" \
  --set "global.redis.enableCluster=true" \
);

if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$DEBUG" "redis-cluster.sh: setting openshift related redis cluster configuration";
  securityContextArgs=(
    --set "podSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "podSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "containerSecurityContext.seccompProfile.type=RuntimeDefault" \
  );
fi

addDeploymentArgs "${args[@]}";
setVerbose;
helm upgrade "$redisReleaseName" bitnami/redis-cluster --version 10.2.7 \
  --install \
  --namespace "$namespace" \
  --set "password=$TYK_PASSWORD" \
  --set "redis.resourcesPreset=none" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
