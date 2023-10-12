prometheusIngressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  prometheusIngressArgs=(
    --set "server.ingress.enabled=true" \
    --set "server.ingress.annotations.kubernetes\.io\/ingress\.class=$INGRESS_CLASSNAME" \
  );
fi
