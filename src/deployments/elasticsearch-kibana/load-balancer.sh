elasticsearchKibanaLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  elasticsearchKibanaLoadbalancerArgs=(
    --set "service.type=LoadBalancer" \
  );
fi
