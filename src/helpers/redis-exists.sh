set +e
search=$(helm ls -n $namespace | awk '{print $1}' | grep -e "^tyk-redis$");
set -e

if [[ -z $search ]]; then
  redisExists=false;
else
  redisExists=true;
fi
