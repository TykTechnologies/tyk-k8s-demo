logger "$INFO" "installing tyk-operator in $namespace namespace...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorDeploymentPath/manifest.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
