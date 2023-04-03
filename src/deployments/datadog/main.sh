logger "$INFO" "installing $datadogReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$datadogReleaseName" datadog/datadog \
  --install \
  --set "datadog.apiKey=$DATADOG_APIKEY" \
  --set "datadog.site=$DATADOG_SITE" \
  --set "datadog.logLevel=debug" \
  --set "datadog.logs.enabled=true" \
  --set "datadog.logs.containerCollectAll=true" \
  --set "datadog.containerIncludeLogs=image:docker.tyk.io/.* image:tykio/.*" \
  --set "datadog.containerExcludeLogs=image:.*" \
  --set "datadog.dogstatsd.port=$DATADOG_SERVICE_PORT" \
  --set "datadog.dogstatsd.tags=env:$namespace" \
  --set "datadog.dogstatsd.originDetection=true" \
  --set "datadog.dogstatsd.nonLocalTraffic=true" \
  "${datadogSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  --wait --atomic > /dev/null;
unsetVerbose;

source "$datadogDeploymentPath/pump.sh";
source "$datadogDeploymentPath/dashboard.sh";
