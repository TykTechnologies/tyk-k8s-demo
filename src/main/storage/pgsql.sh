postgresReleaseName="tyk-$1-postgres";

logger "$INFO" "installing $postgresReleaseName in namespace $namespace";

securityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$DEBUG" "storage/pgsql.sh: setting openshift related postgres configuration";
  securityContextArgs=(--set "primary.podSecurityContext.fsGroup=$OS_UID_RANGE" \
    --set "primary.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "primary.containerSecurityContext.runAsNonRoot=true" \
    --set "primary.containerSecurityContext.allowPrivilegeEscalation=false" \
    --set "primary.containerSecurityContext.capabilities.drop[0]=ALL" \
    --set "primary.containerSecurityContext.seccompProfile.type=RuntimeDefault");
fi

setVerbose;
helm upgrade "$postgresReleaseName" bitnami/postgresql --version 12.12.10 \
  --install \
  --namespace "$namespace" \
  --set "auth.database=$1" \
  --set "auth.postgresPassword=$TYK_PASSWORD" \
  --set "containerPorts.postgresql=$2" \
  --set "primary.service.ports.postgresql=$2" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
