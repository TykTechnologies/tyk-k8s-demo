portalIngressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  portalIngressArgs=(
    --set "tyk-dev-portal.ingress.enabled=true" \
    --set "tyk-dev-portal.ingress.className=$INGRESS_CLASSNAME" \
  );
fi
