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
helm upgrade "$postgresReleaseName" bitnami/postgresql --version 11.9.7 \
  --install \
  --namespace "$namespace" \
  --set "image.repository=zalbiraw/postgresql" \
  --set "image.tag=12.12.0-debian-11" \
  \
  --set "volumePermissions.image.repository=zalbiraw/bitnami-shell" \
  --set "volumePermissions.image.tag=11.0.0-debian-11" \
  \
  --set "metrics.image.repository=zalbiraw/postgresql-exporter" \
  --set "metrics.image.tag=0.11.1-debian-11" \
  \
  --set "auth.database=$1" \
  --set "auth.postgresPassword=$PASSWORD" \
  --set "containerPorts.postgresql=$2" \
  --set "primary.service.ports.postgresql=$2" \
  "${securityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
