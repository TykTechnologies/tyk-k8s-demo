certManagerReleaseName="tyk-cert-manager";
certManagerDeploymentPath="src/deployments/cert-manager";

if [ -z "$certManagerRegistered" ]; then
  certManagerRegistered=true;
  source "$certManagerDeploymentPath/main.sh";
fi
