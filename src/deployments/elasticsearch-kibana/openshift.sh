elasticsearchKibanaSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  elasticsearchKibanaSecurityContextArgs=(--set "containerSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "containerSecurityContext.runAsUser=$OS_UID_RANGE");
fi
