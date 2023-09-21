ELASTICSEARCH_SERVICE_PORT=9200;
elasticsearchReleaseName="elasticsearch";
elasticsearchDeploymentPath="src/deployments/elasticsearch";

if [ -z "$elasticsearchRegistered" ]; then
  elasticsearchRegistered=true;
  source "$elasticsearchDeploymentPath/ssl.sh";
  source "$elasticsearchDeploymentPath/openshift.sh";
  source "$elasticsearchDeploymentPath/main.sh";
fi
