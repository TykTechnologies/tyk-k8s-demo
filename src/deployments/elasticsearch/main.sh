logger "$INFO" "installing $elasticsearchReleaseName in $namespace namespace...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch --version 19.6.0 \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --set "sysctlImage.enabled=false" \
  "${elasticsearchSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  "$helmFlags" > /dev/null;
unsetVerbose;

source src/deployments/elasticsearch/pump.sh;
