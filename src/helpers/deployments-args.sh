debugFlag="";
if $isDebug; then
  debugFlag="--debug";
fi

deploymentsArgs=();
addDeploymentArgs() {
  deploymentsArgs+=("$@");
}
