set +e
search=$(helm ls -n $namespace | awk '{print $1}' | grep -e "^tyk-operator$");
set -e

if [[ -z $search ]]; then
  operatorExists=false;
else
  operatorExists=true;
fi
