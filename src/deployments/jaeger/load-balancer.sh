JAEGER_SERVICE_TYPE=NodePort;
if [[ $LOADBALANCER == "$expose" ]]; then
  JAEGER_SERVICE_TYPE=LoadBalancer;
fi
