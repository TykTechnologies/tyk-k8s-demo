VAULT_SERVICE_PORT=8200;
vaultReleaseName="vault";
vaultDeploymentPath="src/deployments/vault";

if [ -z "$vaultRegistered" ]; then
  vaultRegistered=true;
  source "$vaultDeploymentPath/main.sh";
fi
