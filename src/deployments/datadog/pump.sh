tags="method\,response_code\,api_version\,api_name\,api_id\,org_id\,tracked\,path\,oauth_id";

args=(--set "pump.extraEnvs[$pumpCtr].name=TYK_PMP_PUMPS_DOGSTATSD_TYPE" \
  --set "pump.extraEnvs[$pumpCtr].value=dogstatsd" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].name=TYK_PMP_PUMPS_DOGSTATSD_META_NAMESPACE" \
  --set "pump.extraEnvs[$(($pumpCtr + 1))].value=tyk-demo-env" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].name=TYK_PMP_PUMPS_DOGSTATSD_META_ADDRESS" \
  --set "pump.extraEnvs[$(($pumpCtr + 2))].value=$datadogReleaseName.$namespace.svc:$DATADOG_SERVICE_PORT" \
  --set "pump.extraEnvs[$(($pumpCtr + 3))].name=TYK_PMP_PUMPS_DOGSTATSD_META_ASYNCUDS" \
  --set "pump.extraEnvs[$(($pumpCtr + 3))].value=true" \
  --set "pump.extraEnvs[$(($pumpCtr + 4))].name=TYK_PMP_PUMPS_DOGSTATSD_META_ASYNCUDSWRITETIMEOUT" \
  --set "pump.extraEnvs[$(($pumpCtr + 4))].value=2" \
  --set "pump.extraEnvs[$(($pumpCtr + 5))].name=TYK_PMP_PUMPS_DOGSTATSD_META_BUFFERED" \
  --set "pump.extraEnvs[$(($pumpCtr + 5))].value=true" \
  --set "pump.extraEnvs[$(($pumpCtr + 6))].name=TYK_PMP_PUMPS_DOGSTATSD_META_BUFFEREDMAXMESSAGES" \
  --set "pump.extraEnvs[$(($pumpCtr + 6))].value=32" \
  --set "pump.extraEnvs[$(($pumpCtr + 7))].name=TYK_PMP_PUMPS_DOGSTATSD_META_SAMPLERATE" \
  --set "pump.extraEnvs[$(($pumpCtr + 7))].value=0.9999999999" \
  --set "pump.extraEnvs[$(($pumpCtr + 8))].name=TYK_PMP_PUMPS_DOGSTATSD_META_TAGS" \
  --set "pump.extraEnvs[$(($pumpCtr + 8))].value=$tags" );
pumpCtr=$((pumpCtr + 9));

addDeploymentArgs "${args[@]}";

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null
unsetVerbose;
kubectl wait pods --namespace "$namespace" -l "app=pump-$tykReleaseName-$chart" --for=condition=Ready --timeout=30s > /dev/null;
