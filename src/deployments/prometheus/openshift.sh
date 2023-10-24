prometheusSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  prometheusSecurityContextArgs=(
    --set "server.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "server.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "server.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "server.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "server.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "server.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "configmapReload.prometheus.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "configmapReload.prometheus.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "configmapReload.prometheus.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "kube-state-metrics.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "kube-state-metrics.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "kube-state-metrics.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "kube-state-metrics.securityContext.runAsNonRoot=true" \
    --set "kube-state-metrics.securityContext.seccompProfile.type=RuntimeDefault" \
    --set "kube-state-metrics.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "kube-state-metrics.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "alertmanager.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "alertmanager.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "alertmanager.securityContext.allowPrivilegeEscalation=false" \
    --set "alertmanager.securityContext.capabilities.drop[0]=ALL" \
    --set "alertmanager.podSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "alertmanager.podSecurityContext.runAsGroup=$OS_UID_RANGE" \
    --set "alertmanager.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "alertmanager.podSecurityContext.seccompProfile.type=RuntimeDefault" \
    --set "prometheus-node-exporter.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "prometheus-node-exporter.securityContext.runAsGroup=$OS_UID_RANGE" \
    --set "prometheus-node-exporter.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "prometheus-node-exporter.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "prometheus-node-exporter.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "prometheus-node-exporter.containerSecurityContext.seccompProfile.type=RuntimeDefault" \
  );
fi
