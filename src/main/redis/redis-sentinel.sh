logger "$DEBUG" "redis.sh: setting tyk related redis sentinel configuration";
args=(
  --set "global.redis.addrs[0]=$redisReleaseName.$namespace.svc:6379" \
  --set "global.redis.pass=$TYK_PASSWORD" \
);

securityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$DEBUG" "redis.sh: setting openshift related redis sentinel configuration";
  securityContextArgs=(
    --set "replica.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "replica.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "replica.containerSecurityContext.runAsNonRoot=true" \
    --set "replica.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "replica.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "replica.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "sentinel.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "sentinel.containerSecurityContext.runAsNonRoot=true" \
    --set "sentinel.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "sentinel.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "sentinel.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
  );
fi

addDeploymentArgs "${args[@]}";
setVerbose;
helm upgrade "$redisReleaseName" bitnami/redis --version 19.6.2 \
  --install \
  --namespace "$namespace" \
  --set "auth.password=$TYK_PASSWORD" \
  --set "sentinel.enabled=true" \
  --set "replica.resourcesPreset=none" \
  --set "sentinel.resourcesPreset=none" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
