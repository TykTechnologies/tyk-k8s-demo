portalIngressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  portalIngressArgs=(
    --set "tyk-enterprise-portal.ingress.enabled=true" \
    --set "tyk-enterprise-portal.ingress.className=$INGRESS_CLASSNAME" \
  );
fi
