logger "$INFO" "adding tyk logs processing pipeline...";

pipelines=$(curl -s -X GET "https://api.$DATADOG_SITE/api/v1/logs/config/pipelines" \
  -H "Accept: application/json" \
  -H "DD-API-KEY: $DATADOG_APIKEY" \
  -H "DD-APPLICATION-KEY: $DATADOG_APPKEY");

set +e;
search=$(echo "$pipelines" | grep -e "\"name\":\"Tyk\"");
logger "$DEBUG" "datadog/pipeline.sh: search result: $search";
set -e;

if [[ -z $search ]]; then
  logger "$DEBUG" "datadog/pipeline.sh: creating pipeline...";

  curl -s -X POST "https://api.$DATADOG_SITE/api/v1/logs/config/pipelines" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: $DATADOG_APIKEY" \
    -H "DD-APPLICATION-KEY: $DATADOG_APPKEY" \
    -d @"$datadogDeploymentPath/pipeline.json"
else
  logger "$DEBUG" "datadog/pipeline.sh: pipeline already exists...skipping";
fi
