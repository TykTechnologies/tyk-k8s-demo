checkCommand() {
  logger "$DEBUG" "checking if $1 is installed";
  if ! command -v "$1" &> /dev/null; then
    logger "$ERROR" "please make sure $1 is installed";
    exit 1;
  fi
}

checkCommand jq;
checkCommand helm;
checkCommand git;
