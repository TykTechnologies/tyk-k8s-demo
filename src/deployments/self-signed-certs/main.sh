deploymentPath="src/deployments/self-signed-certs";

if ! [ -f "$deploymentPath/certs/tykCA.pem" ]; then
  source "$deploymentPath/generate.sh";
fi

logger "$INFO" "creating self-signed certs secret...";

selfSignedCertsSecretName="self-signed-ca-secret";
selfSignedCertsVolumeName="self-signed-ca-volume";
selfSignedCertsMountPath="/etc/ssl/certs";
selfSignedCertsFilename="tykCA.pem";

kubectl create secret generic "$selfSignedCertsSecretName" \
  --from-file="$selfSignedCertsFilename=$deploymentPath/certs/$selfSignedCertsFilename" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

args=(--set "dash.extraVolumes[$dashExtraVolumesCtr].name=$selfSignedCertsVolumeName" \
  --set "dash.extraVolumes[$dashExtraVolumesCtr].secret.secretName=$selfSignedCertsSecretName" \
  --set "dash.extraVolumeMounts[$dashExtraVolumeMountsCtr].name=$selfSignedCertsVolumeName" \
  --set "dash.extraVolumeMounts[$dashExtraVolumeMountsCtr].mountPath=$selfSignedCertsMountPath/$selfSignedCertsFilename" \
  --set "dash.extraVolumeMounts[$dashExtraVolumeMountsCtr].subPath=$selfSignedCertsFilename" \
  --set "gateway.extraVolumes[$gatewayExtraVolumesCtr].name=$selfSignedCertsVolumeName" \
  --set "gateway.extraVolumes[$gatewayExtraVolumesCtr].secret.secretName=$selfSignedCertsSecretName" \
  --set "gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].name=$selfSignedCertsVolumeName" \
  --set "gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].mountPath=$selfSignedCertsMountPath/$selfSignedCertsFilename" \
  --set "gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].subPath=$selfSignedCertsFilename");

dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumesCtr + 1));
gatewayExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
gatewayExtraVolumeMountsCtr=$((dashExtraVolumesCtr + 1));

addDeploymentArgs "${args[@]}";
