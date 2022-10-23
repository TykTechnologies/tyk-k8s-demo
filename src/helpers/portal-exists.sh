set +e;
search=$(kubectl get pods -n $namespace | awk '{print $1}' | grep -e "^enterprise-portal-");
logger $DEBUG "portal-exists: search result: $search";
set -e;

if [[ -z $search ]]; then
  portalExists=false;
else
  portalExists=true;
fi
