logger "$INFO" "installing tyk-operator in $namespace namespace...";

setVerbose;
helm upgrade "$operatorReleaseName" tyk-helm/tyk-operator \
  --install \
  --namespace "$namespace" \
  "${operatorSecurityContextArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
