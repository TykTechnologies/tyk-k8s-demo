logger "$INFO" "installing $resurfaceReleaseName in $namespace namespace...";

addService "coordinator";

setVerbose;
helm upgrade "$resurfaceReleaseName" resurfaceio/resurface --version 3.4.0 \
  --install \
  --set "ingress.enabled=false" \
  --set "ingress.controller.enabled=false" \
  --set "auth.enabled=true" \
  --set "auth.service.basic.enabled=true" \
  --set "auth.service.basic.credentials[0].username=$USERNAME" \
  --set "auth.service.basic.credentials[0].password=$PASSWORD" \
  --set "custom.service.apiexplorer.type=NodePort" \
  --set "custom.service.apiexplorer.port=$RESURFACE_COORDINATOR_SERVICE_PORT" \
  --set "custom.service.flukeserver.port=$RESURFACE_WORKER_SERVICE_PORT" \
  --namespace "$namespace" \
  --wait --atomic > /dev/null;
unsetVerbose;

source "$resurfaceDeploymentPath/pump.sh";

addSummary "\tResurface deployed";
