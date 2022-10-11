source src/helpers/redis-exists.sh

tykRedisArgs=();

if [ "redis-cluster" == $redis ]; then
  tykRedisArgs=(--set "redis.addrs[0]=tyk-redis-redis-cluster.$namespace.svc.cluster.local:6379" \
    --set "redis.pass=$PASSWORD" \
    --set "redis.enableCluster=true");
else
  tykRedisArgs=(--set "redis.addrs[0]=tyk-redis-master.$namespace.svc.cluster.local:6379" \
    --set "redis.pass=$PASSWORD");
fi

if $redisExists; then
  echo "Warning: tyk-redis release already exists...skipping Redis install."
else
  if [ "redis-cluster" == $redis ]; then
    set -x
    helm install tyk-redis bitnami/redis-cluster  --version 7.6.4 \
      -n $namespace \
      --set "password=$PASSWORD" \
      "${redisSecurityContextArgs[@]}" \
      --wait
    set +x
  else
    set -x
    helm install tyk-redis bitnami/redis  --version 17.3.2 \
      -n $namespace \
      --set "auth.password=$PASSWORD" \
      "${redisSecurityContextArgs[@]}" \
      --wait
    set +x
  fi
fi
