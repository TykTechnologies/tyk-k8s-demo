elasticsearchIngressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  elasticsearchIngressArgs=(
    --set "ingress.enabled=true" \
    --set "ingress.ingressClassName=$INGRESS_CLASSNAME" \
  );
fi
