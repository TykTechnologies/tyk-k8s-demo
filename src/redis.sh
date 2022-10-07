tykRedisArgs=()

if [ $redis == "redis" ]; then
  set -x
  helm install tyk-redis bitnami/redis  --version 17.3.2 \
    -n $namespace \
    --set "auth.password=topsecretpassword" \
    "${redisSecurityContextArgs[@]}" \
    --wait
  set +x

  tykRedisArgs=(--set "redis.addrs[0]=tyk-redis-master.$namespace.svc.cluster.local:6379" \
    --set "redis.pass=topsecretpassword")
else
  set -x
  helm install tyk-redis bitnami/redis-cluster  --version 7.6.4 \
    -n $namespace \
    --set "password=topsecretpassword" \
    "${redisSecurityContextArgs[@]}" \
    --wait
  set +x

  tykRedisArgs=(--set "redis.addrs[0]=tyk-redis-redis-cluster.$namespace.svc.cluster.local:6379" \
    --set "redis.pass=topsecretpassword" \
    --set "redis.enableCluster=true")
fi
