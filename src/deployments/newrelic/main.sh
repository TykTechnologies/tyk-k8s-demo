logger "$INFO" "installing $newrelicReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$newrelicReleaseName" newrelic/nri-bundle --version 5.0.87 \
  --install \
  --set global.licenseKey=$NEWRELIC_LICENSEKEY \
  --set global.cluster=$NEWRELIC_CLUSTER \
  --set global.lowDataMode=true \
  --set newrelic-infrastructure.privileged=true \
  --set kube-state-metrics.image.tag=v2.10.0 \
  --set kube-state-metrics.enabled=true \
  --set kube-state-metrics.service.port=$NEWRELIC_HEALTH_SERVICE_PORT \
  --set kubeEvents.enabled=true \
  --set logging.enabled=true \
  --set newrelic-logging.lowDataMode=false \
  "${newrelicSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

addService "newrelic-kube-state-metrics";
source "$newrelicDeploymentPath/pump.sh";
