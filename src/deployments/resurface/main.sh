logger "$INFO" "installing $resurfaceReleaseName in $namespace namespace...";

addService "coordinator";

setVerbose;
helm upgrade "$resurfaceReleaseName" resurfaceio/resurface --version 3.6.0-0.3.0 \
  --install \
  --set "ingress.enabled=false" \
  --set "ingress.controller.enabled=false" \
  --set "custom.service.apiexplorer.type=NodePort" \
  --set "custom.service.apiexplorer.port=$RESURFACE_COORDINATOR_SERVICE_PORT" \
  --set "custom.service.flukeserver.port=$RESURFACE_WORKER_SERVICE_PORT" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$resurfaceDeploymentPath/pump.sh";

addSummary "\tResurface deployed";
