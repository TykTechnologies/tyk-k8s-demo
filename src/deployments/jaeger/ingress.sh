JAEGER_INGRESS_ENABLED=false;
if [[ $INGRESS == "$expose" ]]; then
  JAEGER_INGRESS_ENABLED=true;
fi
