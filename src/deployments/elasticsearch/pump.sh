args=(--set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].name=TYK_PMP_PUMPS_ELASTICSEARCH_TYPE" \
  --set "tyk-pump.pump.extraEnvs[$pumpExtraEnvsCtr].value=elasticsearch" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].name=TYK_PMP_PUMPS_ELASTICSEARCH_META_ELASTICSEARCHURL" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 1))].value=http://$elasticsearchReleaseName.$namespace.svc:$ELASTICSEARCH_SERVICE_PORT" \
  --set "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].name=TYK_PMP_PUMPS_ELASTICSEARCH_META_VERSION" \
  --set-string "tyk-pump.pump.extraEnvs[$(($pumpExtraEnvsCtr + 2))].value=7");
pumpExtraEnvsCtr=$((pumpExtraEnvsCtr + 3));

addDeploymentArgs "${args[@]}";
upgradeTyk;
