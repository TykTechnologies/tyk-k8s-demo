elasticsearchSSLArgs=();
if [[ "$SSL" == "$SSLMode" ]]; then
  logger "$INFO" "creating self-signed elasticsearch certs secret...";

  elasticsearchSSLSecretName="elasticsearch-ssl-cert";

  kubectl create secret generic "$elasticsearchSSLSecretName" \
    --from-file="tls.crt=$certsPath/$certFilename" \
    --from-file="tls.key=$certsPath/$keyFilename" \
    --from-file="ca.crt=$certsPath/$CACertFilename" \
    --dry-run=client -o=yaml | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;

  elasticsearchSSLArgs=(
    --set-string "security.enabled=true" \
    --set "security.elasticPassword=$TYK_PASSWORD" \
    --set "security.tls.verificationMode=none" \
    --set-string "security.tls.usePemCerts=true" \
    --set "security.tls.keyPassword=$TYK_PASSWORD" \
    --set "security.tls.master.existingSecret=$elasticsearchSSLSecretName" \
    --set "security.tls.master.existingSecret=$elasticsearchSSLSecretName" \
    --set "security.tls.data.existingSecret=$elasticsearchSSLSecretName" \
    --set "security.tls.ingest.existingSecret=$elasticsearchSSLSecretName" \
    --set "security.tls.coordinating.existingSecret=$elasticsearchSSLSecretName" \
  );
fi
