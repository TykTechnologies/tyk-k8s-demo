if [ -z "$jaegerRegistered" ]; then
  jaegerRegistered=true;

  jaegerReleaseName="tyk-jaeger";
  jaegerDeploymentPath="src/deployments/jaeger";

  source "src/deployments/cert-manager/main.safe.sh";
  source "$jaegerDeploymentPath/main.sh";
fi
