loadbalancerArgs=();
if [[ $LOADBALANCER == "$expose" ]]; then
  loadbalancerArgs=(
    --set "tyk-gateway.gateway.service.type=LoadBalancer" \
    --set "tyk-dashboard.dashboard.service.type=LoadBalancer" \
    --set "tyk-pump.pump.service.type=LoadBalancer" \
    --set "tyk-mdcb.mdcb.service.type=LoadBalancer" \
  );
fi
