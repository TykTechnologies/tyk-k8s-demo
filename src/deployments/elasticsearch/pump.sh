args=(--set "pump.extraEnvs[$pumpCtr].name=TYK_PMP_PUMPS_ELASTICSEARCH_TYPE" \
  --set "pump.extraEnvs[$pumpCtr].value=elasticsearch" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].name=TYK_PMP_PUMPS_ELASTICSEARCH_META_ELASTICSEARCHURL" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].value=http://$elasticsearchReleaseName.$namespace.svc:$ELASTICSEARCH_SERVICE_PORT" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].name=TYK_PMP_PUMPS_ELASTICSEARCH_META_VERSION" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].value=7");
pumpCtr=$((pumpCtr + 3));

addDeploymentArgs "${args[@]}";

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null
unsetVerbose;
