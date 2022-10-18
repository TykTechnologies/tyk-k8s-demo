services=();

addService() {
  services+=($1);
}

getPort() {
  set +e
  port=$(kubectl get svc -n $namespace $1 -o jsonpath="{.spec.ports[0].port}");
  set -e
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
  terminatePorts;
  for service in "${services[@]}"; do
    getPort $service;
    logger $INFO "forwarding to http://localhost:$port \tfrom\t svc/$service:$port";
    kubectl port-forward svc/$service -n $namespace $port > /dev/null &
  done
}

cleanPorts() {
  services=($(kubectl get svc -n tyk | awk 'NR > 1 {print $1}'));
  terminatePorts;
}
