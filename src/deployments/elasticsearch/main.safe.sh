ELASTICSEARCH_SERVICE_PORT=9200;
elasticsearchReleaseName="elasticsearch";

if [ -z "$elasticsearchRegistered" ]; then
  elasticsearchRegistered=true;
  source "src/deployments/elasticsearch/openshift.sh";
  source "src/deployments/elasticsearch/main.sh";
fi
