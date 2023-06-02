logger "$INFO" "installing portal in $namespace namespace...";

portalDBName=portal;
portalDBPort=54321;
source src/main/storage/pgsql.sh $portalDBName $portalDBPort;

addService "enterprise-portal-svc-$tykReleaseName-$chart";
addServiceArgs "enterprisePortal";

args=(--set "enterprisePortal.license=$PORTAL_LICENSE" \
  --set "enterprisePortal.enabled=true" \
  --set "enterprisePortal.bootstrap=false" \
  --set "enterprisePortal.image.tag=$PORTAL_VERSION" \
  --set "enterprisePortal.containerPort=$PORTAL_SERVICE_PORT" \
  --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDBName-postgres-postgresql.$namespace.svc port\=$portalDBPort user\=postgres password\=$PASSWORD database\=$portalDBName sslmode\=disable" \
  "${portalSecurityContextArgs[@]}");

addDeploymentArgs "${args[@]}";
upgradeTyk;

setVerbose;
sed "s/replace_service_url/httpbin-svc.$namespace.svc:8000/g" "$portalDeploymentPath/api-template.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

#sed "s/replace_namespace/$namespace/g" "src/deployments/portal/bootstrap-job-template.yaml" | \
#  sed "s/replace_portal_url/enterprise-portal-svc-$tykReleaseName-$chart.$namespace.svc:$PORTAL_SERVICE_PORT/g" | \
#  sed "s/replace_username/$USERNAME/g" | \
#  sed "s/replace_password/$PASSWORD/g" | \
#  sed "s/replace_first_name/John/g" | \
#  sed "s/replace_last_name/Doe/g" | \
#  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;

#sed "s/replace_namespace/tyk/g" "src/deployments/portal/bootstrap-job-template.yaml" | \
#  sed "s/replace_portal_url/enterprise-portal-svc-tyk-stack-tyk-pro.tyk.svc:3001/g" | \
#  sed "s/replace_username/example@default.com/g" | \
#  sed "s/replace_password/topsecretpassword/g" | \
#  sed "s/replace_first_name/John/g" | \
#  sed "s/replace_last_name/Doe/g" | \
#  kubectl apply -n "tyk" -f - > /dev/null;
