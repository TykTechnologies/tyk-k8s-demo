mongoReleaseName="tyk-mongo";

logger "$INFO" "installing $mongoReleaseName in namespace $namespace";

securityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$DEBUG" "storage/mongo.sh: setting openshift related mongo configuration";
  securityContextArgs=(--set "podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "containerSecurityContext.seccompProfile.type=RuntimeDefault");
fi

setVerbose;
helm upgrade $mongoReleaseName bitnami/mongodb --version 15.6.15 \
  --install \
  --namespace "$namespace" \
  --set "auth.rootPassword=$TYK_PASSWORD" \
  --set "replicaSet.enabled=true" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
