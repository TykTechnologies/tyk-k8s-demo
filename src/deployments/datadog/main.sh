logger "$INFO" "installing $datadogReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$datadogReleaseName" datadog/datadog --version 3.25.1 \
  --install \
  --set "datadog.apiKey=$DATADOG_APIKEY" \
  --set "datadog.site=$DATADOG_SITE" \
  --set "datadog.kubelet.tlsVerify=false" \
  --set "datadog.logLevel=debug" \
  --set "datadog.logs.enabled=true" \
  --set "datadog.logs.containerCollectAll=true" \
  --set "datadog.containerIncludeLogs=image:docker.tyk.io/.* image:tykio/.*" \
  --set "datadog.containerExcludeLogs=image:.*" \
  --set "datadog.dogstatsd.port=$DATADOG_SERVICE_PORT" \
  --set "datadog.dogstatsd.tags=env:$namespace" \
  --set "datadog.dogstatsd.originDetection=true" \
  --set "datadog.dogstatsd.nonLocalTraffic=true" \
  --set "agents.containers.agent.healthPort=$DATADOG_AGENT_HEALTH_SERVICE_PORT" \
  "${datadogSecurityContextArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

source "$datadogDeploymentPath/health.sh";
source "$datadogDeploymentPath/pump.sh";
source "$datadogDeploymentPath/dashboard.sh";
source "$datadogDeploymentPath/pipeline.sh";

addSummary "\tDatadog Agent deployed\n \
\tTyk Dashboard: https://app.$DATADOG_SITE$(echo "$dashboard" | jq -r '.url')\n \
\tDatadog Logs: https://app.$DATADOG_SITE/logs";
