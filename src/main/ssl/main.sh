sslPath="src/main/ssl"
certsPath="$sslPath/certs"
certsSecretName="ssl-secret";
CACertsSecretName="ca-ssl-secret";
selfSignedCertsSecretName="self-signed-ssl-secret";
certsMountPath="/etc/ssl/certs";
CACertFilename="tykCA.pem";
CAKeyFilename="tykCA.key";
certFilename="tyk.local.crt";
keyFilename="tyk.local.key";

if ! [ -f "$certsPath/$CACertFilename" ]; then
  source "$sslPath/generate.sh";
fi

logger "$INFO" "creating self-signed certs secret...";

kubectl create secret generic "$CACertsSecretName" \
  --from-file="$CACertFilename=$certsPath/$CACertFilename" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

kubectl create secret generic "$selfSignedCertsSecretName" \
  --from-file="$certFilename=$certsPath/$certFilename" \
  --from-file="$keyFilename=$certsPath/$keyFilename" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

args=(
  --set "tyk-bootstrap.bootstrap.sslInsecureSkipVerify=true" \

  --set "global.tls.dashboard=true" \
  --set "tyk-dashboard.dashboard.tls.secretName=$certsSecretName" \
  --set "tyk-dashboard.dashboard.tls.insecureSkipVerify=true" \

  --set "global.tls.gateway=true" \
  --set "tyk-gateway.gateway.tls.secretName=$certsSecretName" \
  --set "tyk-gateway.gateway.tls.insecureSkipVerify=true" \

  --set "tyk-dashboard.dashboard.extraVolumes[$dashExtraVolumesCtr].name=$CACertsSecretName" \
  --set "tyk-dashboard.dashboard.extraVolumes[$dashExtraVolumesCtr].secret.secretName=$CACertsSecretName" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].name=$CACertsSecretName" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].mountPath=$certsMountPath/$CACertFilename" \
  --set "tyk-dashboard.dashboard.extraVolumeMounts[$dashExtraVolumeMountsCtr].subPath=$CACertFilename" \

  --set "tyk-gateway.gateway.extraVolumes[$gatewayExtraVolumesCtr].name=$CACertsSecretName" \
  --set "tyk-gateway.gateway.extraVolumes[$gatewayExtraVolumesCtr].secret.secretName=$CACertsSecretName" \
  --set "tyk-gateway.gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].name=$CACertsSecretName" \
  --set "tyk-gateway.gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].mountPath=$certsMountPath/$CACertFilename" \
  --set "tyk-gateway.gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].subPath=$CACertFilename"\

  --set "tyk-pump.pump.extraVolumes[$pumpExtraVolumesCtr].name=$CACertsSecretName" \
  --set "tyk-pump.pump.extraVolumes[$pumpExtraVolumesCtr].secret.secretName=$CACertsSecretName" \
  --set "tyk-pump.pump.extraVolumeMounts[$pumpExtraVolumeMountsCtr].name=$CACertsSecretName" \
  --set "tyk-pump.pump.extraVolumeMounts[$pumpExtraVolumeMountsCtr].mountPath=$certsMountPath/$CACertFilename" \
  --set "tyk-pump.pump.extraVolumeMounts[$pumpExtraVolumeMountsCtr].subPath=$CACertFilename"\

  --set "tyk-mdcb.mdcb.extraVolumes[$mdcbExtraVolumesCtr].name=$CACertsSecretName" \
  --set "tyk-mdcb.mdcb.extraVolumes[$mdcbExtraVolumesCtr].secret.secretName=$CACertsSecretName" \
  --set "tyk-mdcb.mdcb.extraVolumeMounts[$mdcbExtraVolumeMountsCtr].name=$CACertsSecretName" \
  --set "tyk-mdcb.mdcb.extraVolumeMounts[$mdcbExtraVolumeMountsCtr].mountPath=$certsMountPath/$CACertFilename" \
  --set "tyk-mdcb.mdcb.extraVolumeMounts[$mdcbExtraVolumeMountsCtr].subPath=$CACertFilename"\
);

dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumeMountsCtr + 1));

gatewayExtraVolumesCtr=$((gatewayExtraVolumesCtr + 1));
gatewayExtraVolumeMountsCtr=$((gatewayExtraVolumeMountsCtr + 1));

pumpExtraVolumesCtr=$((pumpExtraVolumesCtr + 1));
pumpExtraVolumeMountsCtr=$((pumpExtraVolumeMountsCtr + 1));

mdcbExtraVolumesCtr=$((mdcbExtraVolumesCtr + 1));
mdcbExtraVolumeMountsCtr=$((mdcbExtraVolumeMountsCtr + 1));

addDeploymentArgs "${args[@]}";

addSummary "\tSSL enabled. Self-signed certificates generated. To add the generated certs to your trust store on MAC run the following: \n \
\tsudo security add-trusted-cert \\ \n \
\t\t-d \\ \n \
\t\t-r trustRoot \\ \n \
\t\t-k /Library/Keychains/System.keychain \\ \n \
\t\t$certsPath/tykCA.pem";
