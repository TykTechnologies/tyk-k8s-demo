logger "$INFO" "installing tyk-operator in $namespace namespace...";

setVerbose;
helm upgrade "$operatorReleaseName" tyk-helm/tyk-operator --version 0.15.1 \
  --install \
  --namespace "$namespace" \
  "${operatorSecurityContextArgs[@]}" \
  "${operatorSSLArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
