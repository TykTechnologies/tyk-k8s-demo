logger "$INFO" "installing $k6ReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$k6ReleaseName" grafana/k6-operator --version 3.7.0 \
  --install \
  --set "namespace.create=false" \
  --set "authProxy.enabled=false" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
