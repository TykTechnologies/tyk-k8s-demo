prometheusGrafanaSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  prometheusGrafanaSecurityContextArgs=(--set "securityContext.runAsUser=$OS_UID_RANGE" \
    --set "securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "securityContext.fsGroup=$OS_UID_RANGE" \
    --set "containerSecurityContext.runAsNonRoot=true" \
    --set "containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "containerSecurityContext.seccompProfile.type=RuntimeDefault");
fi
