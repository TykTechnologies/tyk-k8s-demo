set +e;
search=$(kubectl get namespaces | awk '{print $1}' | grep -e "^$namespace$");
logger "$DEBUG" "namespace-exists: search result: $search";
set -e;

if [[ -z $search ]]; then
  namespaceExists=false;
else
  namespaceExists=true;
fi
