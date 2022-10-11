if [[ -z "$LICENSE" || -z "$MDCB_LICENSE" ]]; then
  echo "Please make sure LICENSE and MDCB_LICENSE variables are set in your .env file"
  exit 0
fi

source src/namespace.sh;
source src/redis.sh;
source src/database.sh;

tykArgs=(--set "dash.license=$LICENSE" \
  --set "dash.adminUser.password=$PASSWORD" \
  --set "dash.image.tag=$TYK_DASHBOARD_VERSION" \
  --set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "pump.image.tag=$TYK_PUMP_VERSION")

set -x
helm install tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykDatabaseArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --wait
set +x

source src/helpers/update-hybrid-org.sh;

mdcbArgs=(--set "mdcb.enabled=true" \
	--set "mdcb.license=$MDCB_LICENSE" \
  --set "mdcb.image.tag=$TYK_MDCB_VERSION")

set -x
helm upgrade tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykDatabaseArgs[@]}" \
  "${mdcbArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  "${mdcbSecurityContextArgs[@]}"
set +x
