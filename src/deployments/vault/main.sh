logger "$INFO" "installing $vaultReleaseName in $namespace namespace...";

addService "$vaultReleaseName";
setVerbose;
helm upgrade "$vaultReleaseName" hashicorp/vault \
  --install \
  --namespace "$namespace" \
  --set "server.service.targetPort=$VAULT_SERVICE_PORT" \
  --set "server.service.port=$VAULT_SERVICE_PORT" \
  --set "server.service.readinessProbe.port=$VAULT_SERVICE_PORT" \
  --set "ui.externalPort=$VAULT_SERVICE_PORT" \
  --set "u.targetPort=$VAULT_SERVICE_PORT" \
  --set "server.dev.enabled=true" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
