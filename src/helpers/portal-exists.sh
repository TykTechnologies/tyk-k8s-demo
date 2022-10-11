set +e
search=$(kubectl get pods -n $namespace | awk '{print $1}' | grep -e "^enterprise-portal-");
set -e

if [[ -z $search ]]; then
  portalExists=false;
else
  portalExists=true;
fi
