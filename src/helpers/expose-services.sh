services=();
servicesArgs=();

addService() {
  services+=($1);
}

addServiceArgs() {
  if [[ "mdcb" == $1 ]] && [[ $LOADBALANCER != "$expose" ]]; then
    servicesArgs+=(--set "mdcb.service.type=NodePort");
  else
    if [[ $LOADBALANCER == "$expose" ]]; then
      servicesArgs+=(--set "$1.service.type=LoadBalancer");
    elif [[ $INGRESS == "$expose" ]]; then
      servicesArgs+=(--set "$1.ingress.enabled=true");
      servicesArgs+=(--set "$1.ingress.className=nginx");
    fi
  fi
}

getPort() {
  set +e;
  port=$(kubectl get svc -n "$namespace" "$1" -o jsonpath="{.spec.ports[0].port}");
  set -e;
}

terminatePorts() {
  for service in "${services[@]}"; do
    getPort "$service";

    set +e;
    pid=$(pgrep -f "$service");
    set -e;

    if [[ -n "$pid" ]]; then
      logger "$DEBUG" "terminating port-forwarding ($pid) on port: $port";
      kill -9 "$pid" 2>&1;
    fi
  done
}

exposeServices() {
  servicesSummary="";
  if [[ $PORTFORWARD == "$expose" ]]; then
    terminatePorts;
    for service in "${services[@]}"; do
      getPort "$service";
      kubectl port-forward "svc/$service" -n "$namespace" $port > /dev/null &

      logger "$DEBUG" "forwarding to http://localhost:$port \tfrom\t svc/$service:$port";
      servicesSummary="$servicesSummary\t$(printf "%-50s" "$service") http://localhost:$port\n";
    done
  else
    logger "$DEBUG" "expose not set to port-forward";
  fi
  ## TODO add LOADBALANCER and INGRESS support.

  addSummary "\n\
  \tExposed Services
  $servicesSummary";
}

cleanPorts() {
  services=($(kubectl get svc -n "$namespace" | awk 'NR > 1 {print $1}'));
  terminatePorts;
}
