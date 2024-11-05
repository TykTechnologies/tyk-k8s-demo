logger "$INFO" "installing $jaegerReleaseName in $namespace namespace...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$jaegerDeploymentPath/jaeger-svc-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;

addService "tyk-jaeger";
