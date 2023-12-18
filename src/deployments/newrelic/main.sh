logger "$INFO" "installing $newrelicReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$newrelicReleaseName" newrelic/nri-bundle --version 5.0.56 \
  --install \
  --set global.licenseKey=$NEWRELIC_LICENSEKEY \
  --set global.cluster=tyk-integration \
  --set newrelic-infrastructure.privileged=true \
  --set kube-state-metrics.image.tag=v2.10.0 \
  --set kube-state-metrics.enabled=true \
  --set kubeEvents.enabled=true \
  --set logging.enabled=true \
  --set newrelic-logging.lowDataMode=false \
  "${newrelicSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$newrelicDeploymentPath/pump.sh";
