args=(--set "global.components.pump=true" \
  --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_PMP_PUMPS_RESURFACEIO_TYPE" \
  --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].value=resurfaceio" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].name=TYK_PMP_PUMPS_RESURFACEIO_META_URL" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].value=http://worker.$namespace.svc:$RESURFACE_WORKER_SERVICE_PORT/message" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].name=TYK_PMP_PUMPS_RESURFACEIO_META_RULES" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].value=include debug");
pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 3));

addDeploymentArgs "${args[@]}";
