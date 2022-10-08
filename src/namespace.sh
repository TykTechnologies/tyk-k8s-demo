kubectl create ns $namespace

redisSecurityContextArgs=()
mongoSecurityContextArgs=()
postgresSecurityContextArgs=()
tykSecurityContextArgs=()
gatewaySecurityContextArgs=()
mdcbSecurityContextArgs=()
postalSecurityContextArgs=()

if [ "openshift" == $flavor ]; then
  sleep 1;

  ID=$(kubectl get ns $namespace -o=jsonpath='{.metadata.annotations.openshift\.io\/sa\.scc\.uid-range}' | rev | cut -c7- | rev);

  # Set Redis args
  if [ "redis-cluster" == $redis ]; then
    redisSecurityContextArgs=(--set "podSecurityContext.runAsUser=$ID" \
      --set "podSecurityContext.fsGroup=$ID" \
      --set "containerSecurityContext.runAsUser=$ID")
  else
    redisSecurityContextArgs=(--set "master.podSecurityContext.fsGroup=$ID" \
      --set "master.containerSecurityContext.runAsUser=$ID" \
      --set "replica.podSecurityContext.fsGroup=$ID" \
      --set "replica.containerSecurityContext.runAsUser=$ID")
  fi

  # Set Mongo args
  mongoSecurityContextArgs=(--set "podSecurityContext.fsGroup=$ID" \
    --set "containerSecurityContext.runAsUser=$ID")

  # Set Postgres args
  postgresSecurityContextArgs=(--set "primary.podSecurityContext.fsGroup=$ID" \
    --set "primary.containerSecurityContext.runAsUser=$ID")

  # Set Tyk args
  tykSecurityContextArgs=(--set "dash.securityContext.fsGroup=$ID" \
    --set "dash.securityContext.runAsUser=$ID" \
    --set "pump.securityContext.fsGroup=$ID" \
    --set "pump.securityContext.runAsUser=$ID")

  gatewaySecurityContextArgs=(--set "gateway.securityContext.fsGroup=$ID" \
    --set "gateway.securityContext.runAsUser=$ID")

  # Set MDCB args
  mdcbSecurityContextArgs=(--set "mdcb.securityContext.fsGroup=$ID" \
    --set "mdcb.securityContext.runAsUser=$ID")

  # Set Portal args
  potalSecurityContextArgs=(--set "enterprisePortal.securityContext.fsGroup=$ID" \
    --set "enterprisePortal.securityContext.runAsUser=$ID")
fi
