if [ -z "$k6Registered" ]; then
  k6Registered=true;

  k6DeploymentPath="src/deployments/k6";

  source "$k6DeploymentPath/main.sh";
fi
