deploymentPath="src/deployments/self-signed-certs";

if ! [ -f "$deploymentPath/certs/tykCA.pem" ]; then
  source "$deploymentPath/generate.sh";
fi

logger "$INFO" "creating self-signed certs secret...";

kubectl create secret generic self-signed-ca-secret \
  --from-file="tykCA.pem=$deploymentPath/certs/tykCA.pem" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
