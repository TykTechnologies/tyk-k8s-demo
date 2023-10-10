operatorSSLArgs=();
if [[ "$SSL" == "$SSLMode" ]]; then
  operatorSSLArgs=(
    --set "envVars[0].name=TYK_HTTPS_INGRESS_PORT" \
    --set-string "envVars[0].value=8443" \
    --set "envVars[1].name=TYK_HTTP_INGRESS_PORT" \
    --set-string "envVars[1].value=8080" \
    --set "envVars[2].name=TYK_TLS_INSECURE_SKIP_VERIFY" \
    --set-string "envVars[2].value=true" \
  );
fi
