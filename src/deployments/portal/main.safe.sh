if ! $portalRegistered; then
  portalRegistered=true;
  source "src/deployments/portal/main.sh";
fi

addService "enterprise-portal-svc-$tykReleaseName";
addServiceArgs "enterprisePortal";
