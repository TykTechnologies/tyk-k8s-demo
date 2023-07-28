sslPath="src/main/ssl"
certsPath="$sslPath/certs"
certsSecretName="ssl-secret";
CACertsMountPath="/etc/ssl/certs";
CACertFilename="tykCA.pem";

if ! [ -f "$certsPath/$CACertFilename" ]; then
  source "$sslPath/generate.sh";
fi

logger "$INFO" "creating self-signed certs secret...";

certs="[{\"cert_file\": \"$certsMountPath/tls\.crt\"\,\"key_file\": \"$certsMountPath/tls\.key\"}]"

kubectl create secret generic "$certsSecretName" \
  --from-file="$CACertFilename=$certsPath/$CACertFilename" \
  --from-file="tls.crt=$certsPath/tyk.local.crt" \
  --from-file="tls.key=$certsPath/tyk.local.key" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

args=(--set "tyk-bootstrap.bootstrap.dashboard.sslInsecureSkipVerify=true" \
  --set "global.tls.useDefaultTykCertificate=false" \

  --set "global.tls.dashboard=true" \
  --set "tyk-dashboard.dashboard.tls.secretName=$certsSecretName" \
  --set "tyk-dashboard.dashboard.tls.insecureSkipVerify=true" \

  --set "global.tls.gateway=true" \
  --set "tyk-gateway.gateway.tls.secretName=$certsSecretName" \
  --set "tyk-gateway.gateway.tls.insecureSkipVerify=true" \

  --set "tyk-dashboard.dashboard.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 0))].name=$certsSecretName" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 0))].mountPath=$CACertsMountPath/$CACertFilename" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$((dashExtraVolumeMountsCtr + 0))].subPath=$CACertFilename" \

  --set "tyk-gateway.gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 0))].name=$certsSecretName" \
  --set "tyk-gateway.gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 0))].mountPath=$CACertsMountPath/$CACertFilename" \
  --set "tyk-gateway.gateway.extraVolumeMounts[$((gatewayExtraVolumeMountsCtr + 0))].subPath=$CACertFilename");

dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumeMountsCtr + 3));
dashExtraEnvsCtr=$((dashExtraEnvsCtr + 2));

gatewayExtraVolumeMountsCtr=$((gatewayExtraVolumeMountsCtr + 1));
gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 1));

addDeploymentArgs "${args[@]}";
