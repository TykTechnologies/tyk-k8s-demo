gatewayExtraEnvs=();
dashboardExtraEnvs=();
mdcbExtraEnvs=();
pumpExtraEnvs=();

gatewayPrefix="TYK_GW_";
dashboardPrefix="TYK_DB_";
mdcbPrefix="TYK_MDCB_";
pumpPrefix="TYK_PMP_";

gatewayCtr=0;
dashboardCtr=0;
mdcbCtr=0;
pumpCtr=0;

# Check for .env file, if found, load variables
if [[ -f .env ]]; then
  while IFS= read -r line; do
    IFS='=' read -ra var <<< "$line"
    if [[ -z $(eval "echo \$${var[0]}") ]]; then
      export "${var[0]}=${var[1]}";

      if [[ "${var[0]}" == "$gatewayPrefix"* ]]; then
        echo "${var[0]}"
        gatewayExtraEnvs+=(--set "gateway.extraEnvs[$gatewayCtr].name=${var[0]}" \
          --set "gateway.extraEnvs[$gatewayCtr].value=${var[1]}");
        gatewayCtr+=1;
      elif [[ "${var[0]}" == "$dashboardPrefix"* ]]; then
        dashboardExtraEnvs+=(--set "dash.extraEnvs[$dashboardCtr].name=${var[0]}" \
          --set "dash.extraEnvs[$dashboardCtr].value=${var[1]}");
        dashboardCtr+=1;
      elif [[ "${var[0]}" == "$mdcbPrefix"* ]]; then
        mdcbExtraEnvs+=(--set "mdcb.extraEnvs[$mdcbCtr].name=${var[0]}" \
          --set "mdcb.extraEnvs[$mdcbCtr].value=${var[1]}");
        mdcbCtr+=1;
      elif [[ "${var[0]}" == "$pumpPrefix"* ]]; then
        pumpExtraEnvs+=(--set "pump.extraEnvs[$pumpCtr].name=${var[0]}" \
          --set "pump.extraEnvs[$pumpCtr].value=${var[1]}");
        pumpCtr+=1;
      fi
    fi
  done < .env
else
  logger $ERROR ".env file not found";
  exit 1;
fi
