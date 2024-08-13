source src/helpers/up/namespace-exists.sh;

if $namespaceExists; then
  logger "$INFO" "namespace $namespace already exists...skipping namespace creation";
else
  logger "$INFO" "creating $namespace namespace...";
  kubectl create ns "$namespace" > /dev/null;
  logger "$INFO" "namespace $namespace created";
fi

tykSecurityContextArgs=();
gatewaySecurityContextArgs=();
mdcbSecurityContextArgs=();
if [[ $OPENSHIFT == "$flavor" ]]; then
  logger "$INFO" "generating security context values for the OpenShift environment";
  sleep 5;
  portsWait=60;

  OS_UID_RANGE=$(kubectl get ns "$namespace" -o=jsonpath='{.metadata.annotations.openshift\.io\/sa\.scc\.uid-range}' | rev | cut -c7- | rev);

  logger "$INFO" "using $OS_UID_RANGE for OpenShift security context values";
  # Set Tyk args
  tykSecurityContextArgs=( \
    --set "tyk-dashboard.dashboard.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "tyk-dashboard.dashboard.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "tyk-dashboard.dashboard.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "tyk-pump.pump.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "tyk-pump.pump.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "tyk-pump.pump.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
    --set "tyk-bootstrap.bootstrap.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
  );

  gatewaySecurityContextArgs=( \
    --set "tyk-gateway.gateway.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "tyk-gateway.gateway.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "tyk-gateway.gateway.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
  );

  # Set MDCB args
  mdcbSecurityContextArgs=( \
    --set "tyk-mdcb.mdcb.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "tyk-mdcb.mdcb.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "tyk-mdcb.mdcb.containerSecurityContext.runAsUser=$OS_UID_RANGE" \
  );
fi
