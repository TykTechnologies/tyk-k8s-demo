if [ -z "$certManagerRegistered" ]; then
  certManagerRegistered=true;

  certManagerReleaseName="tyk-cert-manager";
  certManagerDeploymentPath="src/deployments/cert-manager";

  source "$certManagerDeploymentPath/main.sh";
fi
