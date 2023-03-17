prometheusGrafanaSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  prometheusGrafanaSecurityContextArgs=(--set "securityContext.runAsUser=$OS_UID_RANGE" \
    --set "securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "securityContext.fsGroup=$OS_UID_RANGE");
fi
