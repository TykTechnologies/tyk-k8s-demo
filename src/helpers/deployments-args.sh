if $isDebug; then
  deploymentsArgs=(--debug);
else
  deploymentsArgs=();
fi

addDeploymentArgs() {
  deploymentsArgs+=("$@");
}
