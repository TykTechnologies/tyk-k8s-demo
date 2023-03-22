deploymentPath="src/deployments/k6";

set +e;
search=$(kubectl get pods -n k6-operator-system 2> /dev/null | awk '{print $1}' | grep -e "^k6-operator-controller-manager-");
logger "$DEBUG" "k6/operator-exists: search result: $search";
set -e;

if [[ -z $search ]]; then
  logger "$INFO" "installing k6-operator in $namespace namespace...";

  git clone https://github.com/grafana/k6-operator.git "$deploymentPath/k6-operator" &> /dev/null;
  dir=$(pwd);
  cd "$deploymentPath/k6-operator";
  make deploy > /dev/null;
  cd "$dir";
  rm -rf "$deploymentPath/k6-operator";
fi
