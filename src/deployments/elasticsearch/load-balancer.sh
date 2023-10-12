elasticsearchLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  elasticsearchLoadbalancerArgs=(
    --set "service.type=LoadBalancer" \
  );
fi
