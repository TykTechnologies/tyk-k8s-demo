logger "$INFO" "installing tyk-operator in $namespace namespace...";

setVerbose;
helm upgrade "$operatorReleaseName" tyk-helm/tyk-operator --version 0.18.0 \
  --install \
  --namespace "$namespace" \
  "${operatorSecurityContextArgs[@]}" \
  "${operatorSSLArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
