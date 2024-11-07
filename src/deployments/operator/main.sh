logger "$INFO" "installing tyk-operator in $namespace namespace...";

setVerbose;
helm upgrade "$operatorReleaseName" tyk-helm/tyk-operator --version 1.0.0 \
  --install \
  --namespace "$namespace" \
  --set image.repository=buraksekili/tyk-operator\
  --set image.tag=wip-streams \
  "${operatorSecurityContextArgs[@]}" \
  "${operatorSSLArgs[@]}" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
