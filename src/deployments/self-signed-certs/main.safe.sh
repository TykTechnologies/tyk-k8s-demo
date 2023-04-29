selfSignedCertsDeploymentPath="src/deployments/self-signed-certs";

if [ -z "$selfSignedCertsRegistered" ]; then
  selfSignedCertsRegistered=true;
  source "$selfSignedCertsDeploymentPath/main.sh";
fi
