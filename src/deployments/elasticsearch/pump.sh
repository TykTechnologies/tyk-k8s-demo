args=(--set "pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_PMP_PUMPS_ELASTICSEARCH_TYPE" \
  --set "pump.extraEnvs[$pumpExtraEnvsCtr].value=elasticsearch" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].name=TYK_PMP_PUMPS_ELASTICSEARCH_META_ELASTICSEARCHURL" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].value=http://$elasticsearchReleaseName.$namespace.svc:$ELASTICSEARCH_SERVICE_PORT" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].name=TYK_PMP_PUMPS_ELASTICSEARCH_META_VERSION" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].value=7");
pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 3));

addDeploymentArgs "${args[@]}";

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null
unsetVerbose;
kubectl wait pods --namespace "$namespace" -l "app=pump-$tykReleaseName-$chart" --for=condition=Ready --timeout=30s > /dev/null;
