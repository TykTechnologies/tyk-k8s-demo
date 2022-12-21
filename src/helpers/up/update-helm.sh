logger "$INFO" "update helm repos...";
helm repo add bitnami https://charts.bitnami.com/bitnami > /dev/null;
helm repo add tyk-helm https://helm.tyk.io/public/helm/charts/ > /dev/null;
helm repo update > /dev/null;
