extraEnvs=();
deploymentsArgs=();

addDeploymentArgs() {
  deploymentsArgs+=("$@");
}

upgradeTyk() {
  setVerbose;
  helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" --version "$tykReleaseVersion" \
    --install \
    --namespace "$namespace" \
    "${deploymentsArgs[@]}" \
    "${helmFlags[@]}" > /dev/null;
  unsetVerbose;
}

gatewayPrefix="TYK_GW_";
dashboardPrefix="TYK_DB_";
mdcbPrefix="TYK_MDCB_";
pumpPrefix="TYK_PMP_";

pumpBackendsCtr=0;
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
        extraEnvs+=(--set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=${var[0]}" \
          --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=${var[1]}");
        gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));
      elif [[ "${var[0]}" == "$dashboardPrefix"* ]]; then
        extraEnvs+=(--set-string "tyk-dashboard.dashboard.extraEnvs[$dashExtraEnvsCtr].name=${var[0]}" \
          --set-string "tyk-dashboard.dashboard.extraEnvs[$dashExtraEnvsCtr].value=${var[1]}");
        dashExtraEnvsCtr=$((dashExtraEnvsCtr + 1));
      elif [[ "${var[0]}" == "$mdcbPrefix"* ]]; then
        extraEnvs+=(--set-string "tyk-mdcb.mdcb.extraEnvs[$mdcbExtraEnvsCtr].name=${var[0]}" \
          --set-string "tyk-mdcb.mdcb.extraEnvs[$mdcbExtraEnvsCtr].value=${var[1]}");
        mdcbExtraEnvsCtr=$((mdcbExtraEnvsCtr + 1));
      elif [[ "${var[0]}" == "$pumpPrefix"* ]]; then
        extraEnvs+=(--set-string "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].name=${var[0]}" \
          --set-string "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].value=${var[1]}");
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

  extraEnvs+=(--set "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=TYK_LOGLEVEL" \
    --set "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=DEBUG" \
    --set "tyk-dashboard.dashboard.extraEnvs[$dashExtraEnvsCtr].name=TYK_LOGLEVEL" \
    --set "tyk-dashboard.dashboard.extraEnvs[$dashExtraEnvsCtr].value=DEBUG" \
    --set "tyk-mdcb.mdcb.extraEnvs[$mdcbExtraEnvsCtr].name=TYK_LOGLEVEL" \
    --set "tyk-mdcb.mdcb.extraEnvs[$mdcbExtraEnvsCtr].value=DEBUG" \
    --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_LOGLEVEL" \
    --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].value=DEBUG");

  gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));
  dashExtraEnvsCtr=$((dashExtraEnvsCtr + 1));
  mdcbExtraEnvsCtr=$((mdcbExtraEnvsCtr + 1));
  pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 1));
fi
