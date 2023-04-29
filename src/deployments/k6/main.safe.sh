k6DeploymentPath="src/deployments/k6";

if [ -z "$k6Registered" ]; then
  k6Registered=true;
  source "$k6DeploymentPath/main.sh";
fi
