services=();
servicesArgs=();

addService() {
  services+=($1);
}

addServiceArgs() {
  if [[ "mdcb" == $1 ]] && [[ $LOADBALANCER != $expose ]]; then
    servicesArgs+=(--set "mdcb.service.type=NodePort");
  else
    if [[ $LOADBALANCER == $expose ]]; then
      servicesArgs+=(--set "$1.service.type=LoadBalancer");
    elif [[ $INGRESS == $expose ]]; then
      servicesArgs+=(--set "$1.ingress.enabled=true");
      servicesArgs+=(--set "$1.ingress.className=nginx");
    fi
  fi
}

getPort() {
  set +e;
  port=$(kubectl get svc -n $namespace $1 -o jsonpath="{.spec.ports[0].port}");
  set -e;
}

terminatePorts() {
  for service in "${services[@]}"; do
    getPort $service;
    pid=$(ps | grep "kubectl port-forward svc/$service -n $namespace $port$" | awk '{print $1}');

    if ! [[ -z $pid ]]; then
      logger $DEBUG "terminating port-forwarding on port: $port";
      kill $pid > /dev/null 2>&1 &
    fi
  done
}

exposePorts() {
  if [[ $PORTFORWARD == $expose ]]; then
    terminatePorts;
    for service in "${services[@]}"; do
      getPort $service;
      logger $INFO "forwarding to http://localhost:$port \tfrom\t svc/$service:$port";
      kubectl port-forward svc/$service -n $namespace $port > /dev/null &
    done
  else
    logger $DEBUG "expose not set to port-forward";
  fi
}

cleanPorts() {
  services=($(kubectl get svc -n $namespace | awk 'NR > 1 {print $1}'));
  terminatePorts;
}
