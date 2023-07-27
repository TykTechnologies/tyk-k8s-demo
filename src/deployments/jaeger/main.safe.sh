jaegerReleaseName="tyk-jaeger";
jaegerDeploymentPath="src/deployments/jaeger";

if [ -z "$jaegerRegistered" ]; then
  jaegerRegistered=true;
  source "src/deployments/cert-manager/main.safe.sh";
  source "$jaegerDeploymentPath/main.sh";
fi
