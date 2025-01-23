logger "$INFO" "installing $nodeRedReleaseName in $namespace namespace...";

setVerbose;
sed "s/replace_port/$NODERED_SERVICE_PORT/g" "$nodeRedDeploymentPath/node-red-app-template.yaml" | \
  sed "s/replace_name/$nodeRedReleaseName/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;

addService "$nodeRedReleaseName-svc";
