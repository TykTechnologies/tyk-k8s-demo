source "$deploymentPath/helpers.sh";
source "$deploymentsPath/operator/main.safe.sh";
source "$deploymentsPath/operator-httpbin/main.safe.sh";

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
port=$(kubectl get --namespace "$namespace" "service/gateway-svc-$tykReleaseName" -o json | jq '.spec.ports[0].port');
sed "s/replace_gateway_url/gateway-svc-$tykReleaseName.$namespace.svc:$port/g" "$deploymentPath/configmap-k6-load-test-template.yaml" | \
  sed "s/replace_listen_path/$(kubectl get --namespace "$namespace" tykapis httpbin-keyless -o json | jq -r '.spec.proxy.listen_path' | cut -c 2-)/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

test_name="k6-load-test-$(date +%s)";
sed "s/replace_test_name/$test_name/g" "$deploymentPath/k6-load-test-template.yaml" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

waitForK6Jobs;
kubectl wait --namespace "$namespace" jobs -l k6_cr="$test_name" --for=condition=complete --timeout=1200s > /dev/null && \
  sed "s/replace_test_name/$test_name/g" "$deploymentPath/k6-load-test-template.yaml" | \
    kubectl delete --namespace "$namespace" -f - > /dev/null &

logger "$INFO" "tests will continue to run in the background...";
