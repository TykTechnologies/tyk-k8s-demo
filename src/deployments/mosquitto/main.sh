logger "$INFO" "installing $mosquittoReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$mosquittoReleaseName" t3n/mosquitto --version 2.4.1 \
  --install \
  --namespace "$namespace" \
  --set "service.type=NodePort" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

addService "$mosquittoReleaseName";
