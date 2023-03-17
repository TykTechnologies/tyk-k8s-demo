prometheusSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  prometheusSecurityContextArgs=(--set "server.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "server.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "server.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "alertmanager.podSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "alertmanager.podSecurityContext.runAsGroup=$OS_UID_RANGE" \
    --set "alertmanager.podSecurityContext.fsGroup=$OS_UID_RANGE");
fi
