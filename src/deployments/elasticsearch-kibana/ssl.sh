elasticsearchKibanaSSLArgs=();
if [[ "$SSL" == "$SSLMode" ]]; then
  elasticsearchKibanaSSLArgs=(
    --set "tls.enabled=true" \
    --set "tls.usePemCerts=true"
    --set "tls.keyPassword=$TYK_PASSWORD" \
    --set "tls.existingSecret=$elasticsearchSSLSecretName" \
    --set "elasticsearch.security.auth.enabled=true" \
    --set "elasticsearch.security.auth.createSystemUser=true" \
    --set "elasticsearch.security.auth.kibanaPassword=$TYK_PASSWORD" \
    --set "elasticsearch.security.auth.elasticsearchPasswordSecret=$elasticsearchReleaseName" \
    --set "elasticsearch.security.tls.enabled=true" \
    --set "elasticsearch.security.tls.usePemCerts=true" \
    --set "elasticsearch.security.tls.verificationMode=none" \
    --set "elasticsearch.security.tls.existingSecret=$elasticsearchSSLSecretName" \
  );

  addSummary "\tKibana deployed\n \
    \tUsername: elastic\n \
    \tPassword: $TYK_PASSWORD";
fi
