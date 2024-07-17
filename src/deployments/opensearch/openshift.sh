opensearchSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  opensearchSecurityContextArgs=(
    --set "master.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "master.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "data.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "data.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "coordinating.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "coordinating.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "ingest.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "ingest.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "dashboards.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "dashboards.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
  );
fi
