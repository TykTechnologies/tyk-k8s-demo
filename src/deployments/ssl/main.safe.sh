SSLDeploymentPath="src/deployments/ssl";

if [ -z "$SSLRegistered" ]; then
  SSLRegistered=true;
  source "src/deployments/self-signed-certs/main.safe.sh";
  source "$SSLDeploymentPath/main.sh";
fi
