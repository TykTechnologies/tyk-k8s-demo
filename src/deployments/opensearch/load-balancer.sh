OPENsearchLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  OPENsearchLoadbalancerArgs=(
    --set "service.type=LoadBalancer" \
  );
fi
