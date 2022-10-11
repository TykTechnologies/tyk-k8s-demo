if [[ -z "$TYK_HYBRID_CONNECTIONSTRING" || -z "$TYK_HYBRID_ORGID" || -z "$TYK_HYBRID_AUTHTOKEN" ]]; then
  echo "Please make sure TYK_HYBRID_CONNECTIONSTRING, TYK_HYBRID_ORGID and TYK_HYBRID_AUTHTOKEN variables are set in your .env file"
  exit 0
fi

source src/namespace.sh;
source src/redis.sh;

connectionString="$TYK_HYBRID_CONNECTIONSTRING"
rpcKey="$TYK_HYBRID_ORGID"
apiKey="$TYK_HYBRID_AUTHTOKEN"

tykArgs=(--set "gateway.image.tag=$TYK_GATEWAY_VERSION" \
  --set "gateway.rpc.connString=$connectionString" \
  --set "gateway.rpc.rpcKey=$rpcKey" \
  --set "gateway.rpc.apiKey=$apiKey" \
  --set "gateway.service.port=8080")

set -x
helm install tyk-gateway $TYK_HELM_CHART_PATH/tyk-hybrid \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --wait
set +x
