logger "$INFO" "installing $elasticsearchReleaseName in $namespace namespace...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch --version 21.3.5 \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --set "sysctlImage.enabled=false" \
  --set "master.replicaCount=1" \
  --set "master.resources.limits.cpu=0" \
  --set "master.resources.limits.memory=0" \
  --set "master.resources.requests.cpu=0" \
  --set "master.resources.requests.memory=0" \
  --set "data.replicaCount=1" \
  --set "data.resources.limits.cpu=0" \
  --set "data.resources.limits.memory=0" \
  --set "data.resources.requests.cpu=0" \
  --set "data.resources.requests.memory=0" \
  --set "coordinating.replicaCount=1" \
  --set "coordinating.resources.limits.cpu=0" \
  --set "coordinating.resources.limits.memory=0" \
  --set "coordinating.resources.requests.cpu=0" \
  --set "coordinating.resources.requests.memory=0" \
  --set "ingest.replicaCount=1" \
  --set "ingest.resources.limits.cpu=0" \
  --set "ingest.resources.limits.memory=0" \
  --set "ingest.resources.requests.cpu=0" \
  --set "ingest.resources.requests.memory=0" \
  "${elasticsearchSecurityContextArgs[@]}" \
  "${elasticsearchSSLArgs[@]}" \
  "${elasticsearchLoadbalancerArgs[@]}" \
  "${elasticsearchIngressArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$elasticsearchDeploymentPath/pump.sh";
