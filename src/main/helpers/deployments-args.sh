deploymentsArgs=();

addDeploymentArgs() {
  logger $DEBUG "addDeploymentArgs: passed args ${@}"
  deploymentsArgs+=("$@");
}
