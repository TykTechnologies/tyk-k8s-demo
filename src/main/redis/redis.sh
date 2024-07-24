logger "$DEBUG" "redis.sh: setting tyk related redis configuration";
args=(
  --set "global.redis.addrs[0]=$redisReleaseName-master.$namespace.svc:6379" \
  --set "global.redis.pass=$TYK_PASSWORD" \
);

if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$DEBUG" "redis.sh: setting openshift related redis configuration";
  securityContextArgs=(
    --set "master.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "master.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "master.containerSecurityContext.runAsNonRoot=true" \
    --set "master.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "master.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "master.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "replica.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "replica.podSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "replica.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "replica.containerSecurityContext.runAsNonRoot=true" \
    --set "replica.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "replica.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "replica.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
  );
fi

addDeploymentArgs "${args[@]}";
setVerbose;
helm upgrade $redisReleaseName bitnami/redis --version 19.6.2 \
  --install \
  --namespace "$namespace" \
  --set "replica.replicaCount=0" \
  --set "auth.password=$TYK_PASSWORD" \
  --set "master.resourcesPreset=none" \
  --set "replica.resourcesPreset=none" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
