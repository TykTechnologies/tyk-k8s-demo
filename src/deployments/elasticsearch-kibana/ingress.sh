elasticsearchKibanaIngressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  elasticsearchKibanaIngressArgs=(
    --set "ingress.enabled=true" \
    --set "ingress.ingressClassName=$INGRESS_CLASSNAME" \
  );
fi
