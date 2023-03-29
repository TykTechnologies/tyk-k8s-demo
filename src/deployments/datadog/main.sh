logger "$INFO" "installing $datadogReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$datadogReleaseName" datadog/datadog \
  --install \
  --set "datadog.apiKey=$DATADOG_APIKEY" \
  --set "datadog.site=$DATADOG_SITE" \
  --set "datadog.logLevel=debug" \
  --set "datadog.acExclude=redis" \
  --set "datadog.dogstatsd.originDetection=true" \
  --set "datadog.processAgent.enabled=true" \
  --set "datadog.processAgent.processCollection=true" \
  --set "dogstatsd.port=$DATADOG_SERVICE_PORT" \
  --set "dogstatsd.tags=env:$namespace" \
  --set "logs.enabled=true" \
  "${datadogSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  --wait --atomic > /dev/null;
unsetVerbose;

source src/deployments/datadog/pump.sh;
