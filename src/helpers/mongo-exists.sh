set +e
search=$(helm ls -n $namespace | awk '{print $1}' | grep -e "^tyk-mongo$");
set -e

if [[ -z $search ]]; then
  mongoExists=false;
else
  mongoExists=true;
fi
