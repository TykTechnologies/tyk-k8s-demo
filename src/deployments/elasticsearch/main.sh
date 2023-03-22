logger "$INFO" "installing $elasticsearchReleaseName in $namespace namespace...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --set "sysctlImage.enabled=false" \
  "${elasticsearchSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  --timeout 10m \
  --wait > /dev/null;
unsetVerbose;

source src/deployments/elasticsearch/pump.sh;
