logger $DEBUG "Installing operator";

if [[ $TYKPRO != $mode ]] && [[ $TYKCP != $mode ]] && [[ $TYKGATEWAY != $mode ]]; then
  logger $INFO "you need an operator secret to install the operator with a worker gateway";
fi

operatorReleaseName="tyk-operator";
checkHelmReleaseExists $operatorReleaseName;

if $releaseExists; then
  logger $INFO "$operatorReleaseName release already exists in $namespace namespace...skipping $operatorReleaseName install";
else
  setVerbose;
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml;
  sleep 1;
  helm install $operatorReleaseName tyk-helm/tyk-operator -n $namespace;
  unsetVerbose;
fi
