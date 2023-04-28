redisReleaseName="tyk-redis";

logger "$INFO" "installing $redisReleaseName in $namespace namespace";

tykRedisArgs=();
securityContextArgs=();
if [[ $REDISCLUSTER == "$redis" ]]; then
  source src/main/redis/redis-cluster.sh;
elif [[ $REDISSENTINEL == "$redis" ]]; then
  source src/main/redis/redis-sentinel.sh;
else
  source src/main/redis/redis.sh;
fi
