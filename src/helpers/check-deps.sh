checkCommand() {
  logger $DEBUG "Checking if $1 is installed";
  if ! command -v $1 &> /dev/null; then
    logger $ERROR "Please make sure $1 is installed";
    exit 1;
  fi
}

checkCommand jq;
checkCommand helm;
