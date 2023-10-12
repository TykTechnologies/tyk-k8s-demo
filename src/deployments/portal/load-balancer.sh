portalLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  portalLoadbalancerArgs=(
    --set "tyk-enterprise-portal.service.type=LoadBalancer" \
  );
fi
