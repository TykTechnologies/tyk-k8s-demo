if [ -z "$k6Registered" ]; then
  k6Registered=true;

  k6ReleaseName="k6";
  k6DeploymentPath="src/deployments/k6";

  source "$k6DeploymentPath/main.sh";
fi
