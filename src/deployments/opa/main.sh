logger "$INFO" "enabling OPA management for Dashboard API...";

kubectl create configmap opa-rules \
  --from-file="$opaDeploymentPath/dashboard.rego" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

args+=( \
  --set "tyk-dashboard.dashboard.extraEnvs[$dashExtraEnvsCtr].name=TYK_DB_SECURITY_OPENPOLICY_ENABLED" \
  --set-string "tyk-dashboard.dashboard.extraEnvs[$dashExtraEnvsCtr].value=true" \
  --set "tyk-dashboard.dashboard.extraEnvs[$((dashExtraEnvsCtr + 1))].name=TYK_DB_SECURITY_OPENPOLICY_ENABLEAPI" \
  --set-string "tyk-dashboard.dashboard.extraEnvs[$((dashExtraEnvsCtr + 1))].value=true" \
  --set "tyk-dashboard.dashboard.extraVolumes[$dashExtraVolumesCtr].name=opa-rules" \
  --set "tyk-dashboard.dashboard.extraVolumes[$dashExtraVolumesCtr].configMap.name=opa-rules" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].name=opa-rules" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].mountPath=/opt/tyk-dashboard/schemas/dashboard.rego" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].subPath=dashboard.rego" \
);

dashExtraEnvsCtr=$((dashExtraEnvsCtr + 2));
dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumeMountsCtr + 1));

addDeploymentArgs "${args[@]}";
