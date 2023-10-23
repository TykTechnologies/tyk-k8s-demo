if [ -z "$vaultRegistered" ]; then
  vaultRegistered=true;

  VAULT_SERVICE_PORT=8200;
  vaultReleaseName="vault";
  vaultDeploymentPath="src/deployments/vault";

  source "$vaultDeploymentPath/main.sh";
fi
