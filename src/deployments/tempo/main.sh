logger "$INFO" "installing $tempoReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$tempoReleaseName" grafana/tempo --version v1.10.3 \
  --install \
  --namespace "$namespace" \
  --set "tempoQuery.enabled=true" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
