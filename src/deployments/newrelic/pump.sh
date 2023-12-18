args=(
  --set "global.components.pump=true" \
  --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_PMP_PUMPS_STDOUT_TYPE" \
  --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].value=stdout" \
);

pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 1));

addDeploymentArgs "${args[@]}";
