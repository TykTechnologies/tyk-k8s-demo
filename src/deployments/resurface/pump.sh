args=(--set "pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_PMP_PUMPS_RESURFACEIO_TYPE" \
  --set "pump.extraEnvs[$pumpExtraEnvsCtr].value=resurfaceio" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].name=TYK_PMP_PUMPS_RESURFACEIO_META_URL" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].value=http://worker.$namespace.svc:$RESURFACE_WORKER_SERVICE_PORT/message" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].name=TYK_PMP_PUMPS_RESURFACEIO_META_RULES" \
  --set "pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].value=include debug");
pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 3));

addDeploymentArgs "${args[@]}";

setVerbose;
helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
  --namespace "$namespace" \
  "${deploymentsArgs[@]}" \
  --wait --atomic > /dev/null
unsetVerbose;
