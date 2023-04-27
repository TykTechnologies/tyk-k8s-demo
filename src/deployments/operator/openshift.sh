operatorSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  operatorSecurityContextArgs=(--set "securityContext.allowPrivilegeEscalation=false" \
    --set "securityContext.capabilities.drop[0]=ALL" \
    --set "securityContext.seccompProfile.type=RuntimeDefault");
fi
