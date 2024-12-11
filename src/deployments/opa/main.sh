logger "$INFO" "enabling OPA management for Dashboard API...";

kubectl create configmap opa-rules \
  --from-file="$opaDeploymentPath/dashboard.rego" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

debug=false;
if [[ $LOGLEVEL == $DEBUG ]]; then
  debug=true;
fi

args+=( \
  --set "tyk-dashboard.dashboard.opa.enabled=true" \
  --set "tyk-dashboard.dashboard.opa.api=true" \
  --set "tyk-dashboard.dashboard.opa.debug=$debug" \
  --set "tyk-dashboard.dashboard.extraVolumes[$dashExtraVolumesCtr].name=opa-rules" \
  --set "tyk-dashboard.dashboard.extraVolumes[$dashExtraVolumesCtr].configMap.name=opa-rules" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].name=opa-rules" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].mountPath=/opt/tyk-dashboard/schemas/dashboard.rego" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].subPath=dashboard.rego" \
);

dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumeMountsCtr + 1));

addDeploymentArgs "${args[@]}";
