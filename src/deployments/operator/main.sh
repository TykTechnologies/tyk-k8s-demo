logger "$INFO" "installing tyk-operator...";

setVerbose;
helm upgrade "$certManagerReleaseName" jetstack/cert-manager \
  --install \
  --version v1.10.1 \
  --set "installCRDs=true" \
  --set "prometheus.enabled=false" \
  "${certManagerSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  --wait > /dev/null;

helm upgrade "$operatorReleaseName" tyk-helm/tyk-operator \
  --install \
  "${tykOperatorSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  --wait > /dev/null;
unsetVerbose;

logger "$INFO" "installed tyk-operator in namespace $namespace";
