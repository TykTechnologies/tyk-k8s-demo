sslPath="src/main/ssl"
certsPath="$sslPath/certs"

if ! [ -f "$certsPath/tykCA.pem" ]; then
  source "$sslPath/generate.sh";
fi

logger "$INFO" "creating self-signed certs secret...";

certsSecretName="ssl-secret";
certsVolumeName="ssl-volume";
certsMountPath="/etc/ssl/certs";
CACertsMountPath="/etc/ssl/certs";
CACertFilename="tykCA.pem";
certFilename="tyk.local.crt";
keyFilename="tyk.local.key";
certs="[{\"cert_file\": \"$certsMountPath/tyk\.local\.crt\"\,\"key_file\": \"$certsMountPath/tyk\.local\.key\"}]"

kubectl create secret generic "$certsSecretName" \
  --from-file="$CACertFilename=$certsPath/$CACertFilename" \
  --from-file="$certFilename=$certsPath/$certFilename" \
  --from-file="$keyFilename=$certsPath/$keyFilename" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

args=(--set "dash.tls=true" \
  --set "dash.extraVolumes[$dashExtraVolumesCtr].name=$certsVolumeName" \
  --set "dash.extraVolumes[$dashExtraVolumesCtr].secret.secretName=$certsSecretName" \

  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 0))].name=$certsVolumeName" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 0))].mountPath=$CACertsMountPath/$CACertFilename" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 0))].subPath=$CACertFilename" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 1))].name=$certsVolumeName" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 1))].mountPath=$certsMountPath/$certFilename" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 1))].subPath=$certFilename" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 2))].name=$certsVolumeName" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 2))].mountPath=$certsMountPath/$keyFilename" \
  --set "dash.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 2))].subPath=$keyFilename" \

  --set "dash.extraEnvs[$((dashExtraEnvsCtr + 0))].name=TYK_DB_HTTPSERVEROPTIONS_CERTIFICATES" \
  --set "dash.extraEnvs[$((dashExtraEnvsCtr + 0))].value=$certs" \
  --set "dash.extraEnvs[$((dashExtraEnvsCtr + 1))].name=TYK_DB_HTTPSERVEROPTIONS_SSLINSECURESKIPVERIFY" \
  --set-string "dash.extraEnvs[$((dashExtraEnvsCtr + 1))].value=true" \

  --set "gateway.tls=true" \
  --set "gateway.extraVolumes[$gatewayExtraVolumesCtr].name=$certsVolumeName" \
  --set "gateway.extraVolumes[$gatewayExtraVolumesCtr].secret.secretName=$certsSecretName" \

  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 0))].name=$certsVolumeName" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 0))].mountPath=$CACertsMountPath/$CACertFilename" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 0))].subPath=$CACertFilename" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 1))].name=$certsVolumeName" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 1))].mountPath=$certsMountPath/$certFilename" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 1))].subPath=$certFilename" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 2))].name=$certsVolumeName" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 2))].mountPath=$certsMountPath/$keyFilename" \
  --set "gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 2))].subPath=$keyFilename" \

  --set "gateway.extraEnvs[$((gatewayExtraEnvsCtr + 0))].name=TYK_GW_HTTPSERVEROPTIONS_CERTIFICATES" \
  --set "gateway.extraEnvs[$((gatewayExtraEnvsCtr + 0))].value=$certs" \
  --set "gateway.extraEnvs[$((gatewayExtraEnvsCtr + 1))].name=TYK_GW_HTTPSERVEROPTIONS_SSLINSECURESKIPVERIFY" \
  --set-string "gateway.extraEnvs[$((gatewayExtraEnvsCtr + 1))].value=true");

dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumeMountsCtr + 3));
dashExtraEnvsCtr=$((dashExtraEnvsCtr + 2));

gatewayExtraVolumesCtr=$((gatewayExtraVolumesCtr + 1));
gatewayExtraVolumeMountsCtr=$((gatewayExtraVolumeMountsCtr + 3));
gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 2));

addDeploymentArgs "${args[@]}";
