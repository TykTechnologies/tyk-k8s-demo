prometheusGrafanaLoadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  prometheusGrafanaLoadbalancerArgs=(
    --set "service.type=LoadBalancer" \
  );
fi
