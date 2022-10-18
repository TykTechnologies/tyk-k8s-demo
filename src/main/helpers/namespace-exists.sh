set +e
search=$(kubectl get namespaces | awk '{print $1}' | grep -e "^$namespace$");
logger $DEBUG "search result: $search"
set -e

if [[ -z $search ]]; then
  namespaceExists=false;
else
  namespaceExists=true;
fi
