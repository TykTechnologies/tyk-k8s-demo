portalSSLArgs=();
if [[ "$SSL" == "$SSLMode" ]]; then
  portalCerts="[{\"CertFile\":\"$certsMountPath/tyk\.local\.crt\"\,\"KeyFile\":\"$certsMountPath/tyk\.local\.key\"}]"
  portalSSLArgs=(
    --set "global.tls.enterprisePortal=true" \

    --set "tyk-dev-portal.extraEnvs[$portalExtraEnvsCtr].name=PORTAL_TLS_ENABLE" \
    --set "tyk-dev-portal.extraEnvs[$portalExtraEnvsCtr].value=true" \
    --set "tyk-dev-portal.extraEnvs[$((portalExtraEnvsCtr + 1))].name=PORTAL_TLS_INSECURE_SKIP_VERIFY" \
    --set "tyk-dev-portal.extraEnvs[$((portalExtraEnvsCtr + 1))].value=true" \
    --set "tyk-dev-portal.extraEnvs[$((portalExtraEnvsCtr + 2))].name=PORTAL_TLS_CERTIFICATES" \
    --set "tyk-dev-portal.extraEnvs[$((portalExtraEnvsCtr + 2))].value=$portalCerts" \

    --set "tyk-dev-portal.extraVolumes[$portalExtraVolumesCtr].name=$CACertsSecretName" \
    --set "tyk-dev-portal.extraVolumes[$portalExtraVolumesCtr].secret.secretName=$CACertsSecretName" \
    --set "tyk-dev-portal.extraVolumeMounts[$portalExtraVolumeMountsCtr].name=$CACertsSecretName" \
    --set "tyk-dev-portal.extraVolumeMounts[$portalExtraVolumeMountsCtr].mountPath=$certsMountPath/$CACertFilename" \
    --set "tyk-dev-portal.extraVolumeMounts[$portalExtraVolumeMountsCtr].subPath=$CACertFilename" \

    --set "tyk-dev-portal.extraVolumes[$((portalExtraVolumesCtr + 1))].name=$selfSignedCertsSecretName" \
    --set "tyk-dev-portal.extraVolumes[$((portalExtraVolumesCtr + 1))].secret.secretName=$selfSignedCertsSecretName" \
    --set "tyk-dev-portal.extraVolumeMounts[$((portalExtraVolumeMountsCtr + 1))].name=$selfSignedCertsSecretName" \
    --set "tyk-dev-portal.extraVolumeMounts[$((portalExtraVolumeMountsCtr + 1))].mountPath=$certsMountPath/$certFilename" \
    --set "tyk-dev-portal.extraVolumeMounts[$((portalExtraVolumeMountsCtr + 1))].subPath=$certFilename" \
    --set "tyk-dev-portal.extraVolumeMounts[$((portalExtraVolumeMountsCtr + 2))].name=$selfSignedCertsSecretName" \
    --set "tyk-dev-portal.extraVolumeMounts[$((portalExtraVolumeMountsCtr + 2))].mountPath=$certsMountPath/$keyFilename" \
    --set "tyk-dev-portal.extraVolumeMounts[$((portalExtraVolumeMountsCtr + 2))].subPath=$keyFilename" \
  );

  portalExtraEnvsCtr=$((portalExtraEnvsCtr + 3));
  portalExtraVolumesCtr=$((portalExtraVolumesCtr + 2));
  portalExtraVolumeMountsCtr=$((portalExtraVolumeMountsCtr + 3));
fi
