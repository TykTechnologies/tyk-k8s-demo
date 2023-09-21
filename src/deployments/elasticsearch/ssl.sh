elasticsearchSSLArgs=();
if [[ "$SSL" == "$SSLMode" ]]; then
  elasticsearchSSLArgs=(--set-string "security.enabled=true" \
    --set "security.tls.verificationMode=none" \
    --set-string "security.tls.usePemCerts=true"
    --set "security.tls.master.existingSecret=$certsSecretName" \
    --set "security.tls.data.existingSecret=$certsSecretName" \
    --set "security.tls.ingest.existingSecret=$certsSecretName" \
    --set "security.tls.coordinating.existingSecret=$certsSecretName" \
    );
fi
