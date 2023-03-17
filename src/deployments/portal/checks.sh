if [[ $TYKSTACK != "$mode" ]] && [[ $TYKCP != "$mode" ]]; then
  logger "$ERROR" "can only install the enterprise portal with a tyk-stack or a tyk-cp installation";
  exit 1;
fi

if [[ -z "$PORTAL_LICENSE" ]]; then
  logger "$ERROR" "Please make sure the PORTAL_LICENSE variable is set in your .env file";
  exit 1;
else
  checkLicense "$PORTAL_LICENSE"
  if $expired; then
    logger "$ERROR" "Your Enterprise Portal license has expired or is invalid. Please provide another license key";
    exit 1;
  fi
fi
