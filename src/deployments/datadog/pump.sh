tags="method\,response_code\,api_version\,api_name\,api_id\,org_id\,tracked\,path\,oauth_id";

args=(--set "pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_PMP_PUMPS_DOGSTATSD_TYPE" \
  --set "pump.extraEnvs[$pumpExtraEnvsCtr].value=dogstatsd" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].name=TYK_PMP_PUMPS_DOGSTATSD_META_NAMESPACE" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].value=$namespace" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].name=TYK_PMP_PUMPS_DOGSTATSD_META_ADDRESS" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].value=$datadogReleaseName.$namespace.svc:$DATADOG_SERVICE_PORT" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 3))].name=TYK_PMP_PUMPS_DOGSTATSD_META_ASYNCUDS" \
  --set-string "pump.extraEnvs[$(($pumpExtraEnvsCtr + 3))].value=true" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 4))].name=TYK_PMP_PUMPS_DOGSTATSD_META_ASYNCUDSWRITETIMEOUT" \
  --set-string "pump.extraEnvs[$(($pumpExtraEnvsCtr + 4))].value=2" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 5))].name=TYK_PMP_PUMPS_DOGSTATSD_META_BUFFERED" \
  --set-string "pump.extraEnvs[$(($pumpExtraEnvsCtr + 5))].value=true" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 6))].name=TYK_PMP_PUMPS_DOGSTATSD_META_BUFFEREDMAXMESSAGES" \
  --set-string "pump.extraEnvs[$(($pumpExtraEnvsCtr + 6))].value=32" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 7))].name=TYK_PMP_PUMPS_DOGSTATSD_META_SAMPLERATE" \
  --set-string "pump.extraEnvs[$(($pumpExtraEnvsCtr + 7))].value=0.9999999999" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 8))].name=TYK_PMP_PUMPS_DOGSTATSD_META_TAGS" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 8))].value=$tags");
pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 9));

addDeploymentArgs "${args[@]}";

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  "$helmFlags" > /dev/null;
unsetVerbose;
