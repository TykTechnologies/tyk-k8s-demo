ingressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  ingressArgs=(
    --set "tyk-gateway.gateway.ingress.enabled=true" \
    --set "tyk-gateway.gateway.ingress.className=$INGRESS_CLASSNAME" \

    --set "tyk-dashboard.dashboard.ingress.enabled=true" \
    --set "tyk-dashboard.dashboard.ingress.className=$INGRESS_CLASSNAME" \

    --set "tyk-pump.pump.ingress.enabled=true" \
    --set "tyk-pump.pump.ingress.className=$INGRESS_CLASSNAME" \

    --set "tyk-mdcb.mdcb.ingress.enabled=true" \
    --set "tyk-mdcb.mdcb.ingress.className=$INGRESS_CLASSNAME" \
  );
fi
