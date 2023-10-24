vaultSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  vaultSecurityContextArgs=(
    --set "injector.securityContext.pod.runAsUser=$OS_UID_RANGE" \
    --set "injector.securityContext.pod.runAsGroup=$OS_UID_RANGE" \
    --set "injector.securityContext.pod.fsGroup=$OS_UID_RANGE" \
    --set "server.statefulSet.securityContext.pod.runAsUser=$OS_UID_RANGE" \
    --set "server.statefulSet.securityContext.pod.runAsGroup=$OS_UID_RANGE" \
    --set "server.statefulSet.securityContext.pod.fsGroup=$OS_UID_RANGE" \
    --set "server.statefulSet.securityContext.pod.seccompProfile.type=RuntimeDefault" \
    --set "server.statefulSet.securityContext.container.capabilities.drop[0]=ALL" \
  );
fi
