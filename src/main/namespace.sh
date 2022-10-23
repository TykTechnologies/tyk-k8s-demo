source src/helpers/namespace-exists.sh;

if $namespaceExists; then
  logger $INFO "namespace $namespace already exists...skipping namespace creation";
else
  logger $INFO "creating $namespace namespace...";
  kubectl create ns $namespace > /dev/null;
  logger $INFO "namespace $namespace created";
fi

redisSecurityContextArgs=();
mongoSecurityContextArgs=();
postgresSecurityContextArgs=();
tykSecurityContextArgs=();
gatewaySecurityContextArgs=();
mdcbSecurityContextArgs=();
postalSecurityContextArgs=();

if [[ $OPENSHIFT == $flavor ]]; then
  logger $INFO "generating security context values for the OpenShift environment";
  sleep 1;

  ID=$(kubectl get ns $namespace -o=jsonpath='{.metadata.annotations.openshift\.io\/sa\.scc\.uid-range}' | rev | cut -c7- | rev);

  logger $INFO "using $ID for OpenShift security context values";
  # Set Redis args
  if [[ $REDISCLUSTER == $redis ]]; then
    redisSecurityContextArgs=(--set "podSecurityContext.runAsUser=$ID" \
      --set "podSecurityContext.fsGroup=$ID" \
      --set "containerSecurityContext.runAsUser=$ID");
  elif [[ $REDISSENTINEL == $redis ]]; then
    redisSecurityContextArgs=(--set "replica.podSecurityContext.fsGroup=$ID" \
      --set "replica.containerSecurityContext.runAsUser=$ID" \
      --set "sentinel.containerSecurityContext.runAsUser=$ID");
  else
    redisSecurityContextArgs=(--set "master.podSecurityContext.fsGroup=$ID" \
      --set "master.containerSecurityContext.runAsUser=$ID" \
      --set "replica.podSecurityContext.fsGroup=$ID" \
      --set "replica.containerSecurityContext.runAsUser=$ID");
  fi

  # Set Mongo args
  mongoSecurityContextArgs=(--set "podSecurityContext.fsGroup=$ID" \
    --set "containerSecurityContext.runAsUser=$ID");

  # Set Postgres args
  postgresSecurityContextArgs=(--set "primary.podSecurityContext.fsGroup=$ID" \
    --set "primary.containerSecurityContext.runAsUser=$ID");

  # Set Tyk args
  tykSecurityContextArgs=(--set "dash.securityContext.fsGroup=$ID" \
    --set "dash.securityContext.runAsUser=$ID" \
    --set "pump.securityContext.fsGroup=$ID" \
    --set "pump.securityContext.runAsUser=$ID");

  gatewaySecurityContextArgs=(--set "gateway.securityContext.fsGroup=$ID" \
    --set "gateway.securityContext.runAsUser=$ID");

  # Set MDCB args
  mdcbSecurityContextArgs=(--set "mdcb.securityContext.fsGroup=$ID" \
    --set "mdcb.securityContext.runAsUser=$ID");

  # Set Portal args
  potalSecurityContextArgs=(--set "enterprisePortal.securityContext.fsGroup=$ID" \
    --set "enterprisePortal.securityContext.runAsUser=$ID");
fi
