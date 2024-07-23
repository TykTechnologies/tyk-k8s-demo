opensearchSSLArgs=();
if [[ "$SSL" == "$SSLMode" ]]; then
  logger "$INFO" "creating self-signed opensearch certs secret...";

  opensearchSSLSecretName="opensearch-ssl-cert";

  kubectl create secret generic "$opensearchSSLSecretName" \
    --from-file="tls.crt=$certsPath/$certFilename" \
    --from-file="tls.key=$certsPath/$keyFilename" \
    --from-file="ca.crt=$certsPath/$CACertFilename" \
    --dry-run=client -o=yaml | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;

  opensearchSSLArgs=(
    --set-string "security.enabled=true" \
    --set "security.adminPassword=$TYK_PASSWORD" \
    --set "security.tls.verificationMode=none" \
    --set-string "security.tls.usePemCerts=true" \
    --set "security.tls.keyPassword=$TYK_PASSWORD" \
    --set "security.tls.master.existingSecret=$opensearchSSLSecretName" \
    --set "security.tls.data.existingSecret=$opensearchSSLSecretName" \
    --set "security.tls.ingest.existingSecret=$opensearchSSLSecretName" \
    --set "security.tls.coordinating.existingSecret=$opensearchSSLSecretName" \
  );
fi
