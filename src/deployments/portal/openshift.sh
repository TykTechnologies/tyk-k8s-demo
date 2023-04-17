portalSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  portalSecurityContextArgs=(--set "enterprisePortal.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "enterprisePortal.securityContext.runAsUser=$OS_UID_RANGE");
fi
