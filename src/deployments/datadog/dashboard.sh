logger "$INFO" "creating datadog dashboard...";

dashboards=$(curl -s -X GET "https://api.datadoghq.com/api/v1/dashboard" \
-H "Accept: application/json" \
-H "DD-API-KEY: $DATADOG_APIKEY" \
-H "DD-APPLICATION-KEY: $DATADOG_APPKEY");

set +e;
search=$(echo "$dashboards" | grep -e "\"title\":\"Tyk Dashboard\"");
logger "$DEBUG" "datadog/dashboard.sh: search result: $search";
set -e;

if [[ -z $search ]]; then
  logger "$DEBUG" "datadog/dashboard.sh: creating dashboard...";

  dashboard=$(sed "s/replace_namespace/$namespace/g" "$datadogDeploymentPath/dashboard.json");
  dashboard=$(curl -s -X POST "https://api.$DATADOG_SITE/api/v1/dashboard" \
   -H "Accept: application/json" \
   -H "Content-Type: application/json" \
   -H "DD-API-KEY: $DATADOG_APIKEY" \
   -H "DD-APPLICATION-KEY: $DATADOG_APPKEY" \
   -d "$dashboard");
else
  logger "$DEBUG" "datadog/dashboard.sh: dashboard already exists...skipping";
  dashboard="$(echo "$dashboards" | jq '.dashboards | .[] | select(.title="Tyk Dashboard")')";
fi

addSummary "\n\
\tDatadog Agent deployed\n \
\tTyk Dashboard: https://app.$DATADOG_SITE$(echo "$dashboard" | jq -r '.url')\n";
