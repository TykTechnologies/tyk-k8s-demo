opensearchIngressArgs=();
if [[ $INGRESS == "$expose" ]]; then
  opensearchIngressArgs=(
    --set "ingress.enabled=true" \
    --set "ingress.ingressClassName=$INGRESS_CLASSNAME" \
  );
fi
