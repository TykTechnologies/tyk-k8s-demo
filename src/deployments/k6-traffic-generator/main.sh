deploymentPath="src/deployments/k6-traffic-generator";

source "$deploymentPath/helpers.sh";

checkHttpBinCRDExists;
if ! $httpBinCRDExists; then
  logger "$ERROR" "the operator and operator-httpbin need to be available for this deployment to run...";
  exit 1;
fi

checkK6OperatorExists;
if ! $k6OperatorExists; then
  logger "$INFO" "installing k6-operator...";

  git clone https://github.com/grafana/k6-operator.git "$deploymentPath/k6-operator" &> /dev/null;
  dir=$(pwd); cd "$deploymentPath/k6-operator"; make deploy > /dev/null; cd "$dir";
  rm -rf "$deploymentPath/k6-operator";
else
  logger "$INFO" "k6-operator already installed...";
fi

logger "$INFO" "generating k6 loads...";
port=$(kubectl get -n "$namespace" "service/gateway-svc-$tykReleaseName" -o json | jq '.spec.ports[0].port');
sed "s/gateway_url/gateway-svc-$tykReleaseName.$namespace.svc:$port/g" "$deploymentPath/configmap-k6-load-test-template.yaml" | \
  sed "s/listen_path/$(kubectl get -n "$namespace" tykapis httpbin-keyless -o json | jq -r '.spec.proxy.listen_path' | cut -c 2-)/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

load_test_name="k6-load-test-$(date +%s)";
sed "s/load_test_name/$load_test_name/g" "$deploymentPath/k6-load-test-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

waitForK6Jobs;
kubectl wait -n "$namespace" jobs -l k6_cr="$load_test_name" --for=condition=complete --timeout=1200s > /dev/null && \
  sed "s/load_test_name/$load_test_name/g" "$deploymentPath/k6-load-test-template.yaml" | \
    kubectl delete -n "$namespace" -f - > /dev/null &

logger "$INFO" "tests will continue to run in the background...";
