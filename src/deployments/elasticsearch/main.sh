logger "$INFO" "installing $elasticsearchReleaseName in $namespace namespace...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch --version 19.13.1 \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --set "sysctlImage.enabled=false" \
  --set "master.replicaCount=1" \
  --set "data.replicaCount=1" \
  --set "coordinating.replicaCount=1" \
  --set "ingest.replicaCount=1" \
  "${elasticsearchSecurityContextArgs[@]}" \
  "${elasticsearchSSLArgs[@]}" \
  "${elasticsearchLoadbalancerArgs[@]}" \
  "${elasticsearchIngressArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$elasticsearchDeploymentPath/pump.sh";
