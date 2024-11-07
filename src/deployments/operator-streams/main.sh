logger "$INFO" "creating Tyk Operator streams example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorStreamsDeploymentPath/api-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
