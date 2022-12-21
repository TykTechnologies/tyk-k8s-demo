if $isDebug; then
  deploymentsArgs=(--debug);
else
  deploymentsArgs=();
fi

addDeploymentArgs() {
  logger "$DEBUG" "addDeploymentArgs: passed args ${@}";
  deploymentsArgs+=("$@");
}
