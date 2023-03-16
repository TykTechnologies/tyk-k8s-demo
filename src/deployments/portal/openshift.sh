postalSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  potalSecurityContextArgs=(--set "enterprisePortal.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "enterprisePortal.securityContext.runAsUser=$OS_UID_RANGE");
fi
