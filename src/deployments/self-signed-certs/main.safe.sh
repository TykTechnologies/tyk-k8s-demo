if [ -z "$SelfSignedCertsRegistered" ]; then
  SelfSignedCertsRegistered=true;
  source "src/deployments/self-signed-certs/main.sh";
  patchRequired=true;
fi
