logger "$INFO" "installing $elasticsearchReleaseName in $namespace namespace...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch --version 21.3.5 \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --set "sysctlImage.enabled=false" \
  --set "master.replicaCount=1" \
  --set "master.resourcesPreset=micro" \
  --set "data.replicaCount=1" \
  --set "data.resourcesPreset=micro" \
  --set "coordinating.replicaCount=1" \
  --set "coordinating.resourcesPreset=micro" \
  --set "ingest.replicaCount=1" \
  --set "ingest.resourcesPreset=micro" \
  "${elasticsearchSecurityContextArgs[@]}" \
  "${elasticsearchSSLArgs[@]}" \
  "${elasticsearchLoadbalancerArgs[@]}" \
  "${elasticsearchIngressArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$elasticsearchDeploymentPath/pump.sh";
