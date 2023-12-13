prometheusLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  prometheusLoadbalancerArgs=(
    --set "server.service.type=LoadBalancer" \
  );
fi
