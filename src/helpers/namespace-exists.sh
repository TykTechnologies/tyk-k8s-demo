set +e
search=$(kubectl get namespaces | awk '{print $1}' | grep -e "^$namespace$");
set -e

if [[ -z $search ]]; then
  namespaceExists=false;
else
  namespaceExists=true;
fi
