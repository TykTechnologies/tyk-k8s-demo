if [ -z "$opaRegistered" ]; then
  opaRegistered=true;

  opaDeploymentPath="src/deployments/opa";

  source "$opaDeploymentPath/main.sh";
fi
