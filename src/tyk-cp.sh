source src/namespace.sh;
source src/redis.sh;
source src/database.sh;

tykArgs=(--set "dash.license=$LICENSE" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "dash.adminUser.password=topsecretpassword" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION")

set -x
helm install tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykDatabaseArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  --wait
set +x

source src/update-hybrid.sh;

mdcbArgs=(--set "mdcb.enabled=true" \
	--set "mdcb.license=$MDCB_LICENSE")

set -x
helm upgrade tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykDatabaseArgs[@]}" \
  "${mdcbArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${mdcbSecurityContextArgs[@]}"
set +x
