portalSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  portalSecurityContextArgs=(
    --set "tyk-dev-portal.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "tyk-dev-portal.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "server.statefulSet.securityContext.seccompProfile.type=RuntimeDefault" \
    --set "server.statefulSet.containerSecurityContext.capabilities.drop[0]=ALL" \
  );
fi
