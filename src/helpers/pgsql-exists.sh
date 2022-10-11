set +e
search=$(helm ls -n $namespace | awk '{print $1}' | grep -e "^tyk-$1-postgres$");
set -e

if [[ -z $search ]]; then
  pgsqlExists=false;
else
  pgsqlExists=true;
fi
