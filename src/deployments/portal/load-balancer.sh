portalLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  portalLoadbalancerArgs=(
    --set "tyk-dev-portal.service.type=LoadBalancer" \
  );
fi
