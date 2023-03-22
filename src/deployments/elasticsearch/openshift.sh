elasticsearchSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  elasticsearchSecurityContextArgs=(--set "master.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "master.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "data.containerSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "data.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "coordinating.containerSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "coordinating.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "ingest.containerSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "ingest.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "metrics.containerSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "metrics.containerSecurityContext.runAsUser=$OS_UID_RANGE");
fi
