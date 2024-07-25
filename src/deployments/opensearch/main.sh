logger "$INFO" "installing $opensearchReleaseName in $namespace namespace...";

addService "$opensearchReleaseName";
addService "$opensearchReleaseName-dashboards";

setVerbose;
helm upgrade "$opensearchReleaseName" bitnami/opensearch --version 1.2.8 \
  --install \
  --set "service.ports.restAPI=$OPENSEARCH_SERVICE_PORT" \
  --set "dashboards.enabled=true" \
  --set "dashboards.service.ports.http=$OPENSEARCH_DASHBOARD_SERVICE_PORT" \
  --set "sysctlImage.enabled=false" \
  --set "master.replicaCount=1" \
  --set "data.replicaCount=1" \
  --set "coordinating.replicaCount=1" \
  --set "ingest.replicaCount=1" \
  "${opensearchSecurityContextArgs[@]}" \
  "${opensearchSSLArgs[@]}" \
  "${opensearchLoadbalancerArgs[@]}" \
  "${opensearchIngressArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$opensearchDeploymentPath/pump.sh";
