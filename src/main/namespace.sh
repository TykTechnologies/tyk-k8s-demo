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
  tykSecurityContextArgs=(--set "dash.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "dash.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "dash.securityContext.seccompProfile.type=RuntimeDefault" \
    --set "pump.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "pump.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "pump.securityContext.seccompProfile.type=RuntimeDefault");

  gatewaySecurityContextArgs=(--set "gateway.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "gateway.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "gateway.securityContext.seccompProfile.type=RuntimeDefault");

  # Set MDCB args
  mdcbSecurityContextArgs=(--set "mdcb.securityContext.fsGroup=$OS_UID_RANGE" \
    --set "mdcb.securityContext.runAsUser=$OS_UID_RANGE" \
    --set "mdcb.securityContext.seccompProfile.type=RuntimeDefault");
fi
