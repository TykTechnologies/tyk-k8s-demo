extraEnvs=();
deploymentsArgs=();

addDeploymentArgs() {
  deploymentsArgs+=("$@");
}

gatewayPrefix="TYK_GW_";
dashboardPrefix="TYK_DB_";
mdcbPrefix="TYK_MDCB_";
pumpPrefix="TYK_PMP_";

gatewayExtraEnvsCtr=0;
dashExtraEnvsCtr=0;
mdcbExtraEnvsCtr=0;
pumpExtraEnvsCtr=0;
gatewayExtraVolumesCtr=0;
dashExtraVolumesCtr=0;
mdcbExtraVolumesCtr=0;
pumpExtraVolumesCtr=0;
gatewayExtraVolumeMountsCtr=0;
dashExtraVolumeMountsCtr=0;
mdcbExtraVolumeMountsCtr=0;
pumpExtraVolumeMountsCtr=0;

# Check for .env file, if found, load variables
if [[ -f .env ]]; then
  while IFS= read -r line; do
    IFS='=' read -ra var <<< "$line"
    if [[ -z $(eval "echo \$${var[0]}") ]]; then
      export "${var[0]}=${var[1]}";

      if [[ "${var[0]}" == "$gatewayPrefix"* ]]; then
        extraEnvs+=(--set-string "gateway.extraEnvs[$gatewayExtraEnvsCtr].name=${var[0]}" \
          --set-string "gateway.extraEnvs[$gatewayExtraEnvsCtr].value=${var[1]}");
        gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));
      elif [[ "${var[0]}" == "$dashboardPrefix"* ]]; then
        extraEnvs+=(--set-string "dash.extraEnvs[$dashExtraEnvsCtr].name=${var[0]}" \
          --set-string "dash.extraEnvs[$dashExtraEnvsCtr].value=${var[1]}");
        dashExtraEnvsCtr=$((dashExtraEnvsCtr + 1));
      elif [[ "${var[0]}" == "$mdcbPrefix"* ]]; then
        extraEnvs+=(--set-string "mdcb.extraEnvs[$mdcbExtraEnvsCtr].name=${var[0]}" \
          --set-string "mdcb.extraEnvs[$mdcbExtraEnvsCtr].value=${var[1]}");
        mdcbExtraEnvsCtr=$((mdcbExtraEnvsCtr + 1));
      elif [[ "${var[0]}" == "$pumpPrefix"* ]]; then
        extraEnvs+=(--set-string "pump.extraEnvs[$pumpExtraEnvsCtr].name=${var[0]}" \
          --set-string "pump.extraEnvs[$pumpExtraEnvsCtr].value=${var[1]}");
        pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 1));
      fi
    fi
  done < .env
else
  logger "$ERROR" ".env file not found";
  exit 1;
fi

helmFlags=(--wait --atomic);
if $isDebug; then
  helmFlags+=(--debug);

  extraEnvs+=(--set "gateway.extraEnvs[0].name=TYK_LOGLEVEL" \
    --set "gateway.extraEnvs[0].value=DEBUG" \
    --set "dash.extraEnvs[0].name=TYK_LOGLEVEL" \
    --set "dash.extraEnvs[0].value=DEBUG" \
    --set "mdcb.extraEnvs[0].name=TYK_LOGLEVEL" \
    --set "mdcb.extraEnvs[0].value=DEBUG" \
    --set "pump.extraEnvs[0].name=TYK_LOGLEVEL" \
    --set "pump.extraEnvs[0].value=DEBUG");

  gatewayExtraEnvsCtr=1;
  dashExtraEnvsCtr=1;
  mdcbExtraEnvsCtr=1;
  pumpExtraEnvsCtr=1;
fi
