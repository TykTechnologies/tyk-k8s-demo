certManagerSecurityContextArgs=();
tykOperatorSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  certManagerSecurityContextArgs=(--set "securityContext.runAsUser=$OS_UID_RANGE" \
    --set "securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "webhook.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "webhook.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "cainjector.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "cainjector.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "startupapicheck.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "startupapicheck.securityContext.runAsGroup=$OS_UID_RANGE");

  tykOperatorSecurityContextArgs=(--set "securityContext.runAsUser=$OS_UID_RANGE" \
    --set "securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "rbac.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "rbac.securityContext.runAsGroup=$OS_UID_RANGE");
fi
