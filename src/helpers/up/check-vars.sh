source src/helpers/up/check-license-expiry.sh;

logger "$INFO" "checking variables...";

invalid=false;
chart="tyk-headless";

if [[ $TYKSTACK == "$mode" ]] || [[ $TYKCP == "$mode" ]]; then
  chart="tyk-pro";
  if [[ -z "$LICENSE" ]]; then
    logger "$ERROR" "please make sure the LICENSE variable is set in your .env file";
    invalid=true;
  else
    checkLicense "$LICENSE"
    if $expired; then
      logger "$ERROR" "your Dashboard license has expired or is invalid. Please provide another license key";
      invalid=true;
    fi
  fi
fi

if [[ $TYKCP == "$mode" ]]; then
  if [[ -z "$MDCB_LICENSE" ]]; then
    logger "$ERROR" "please make sure the MDCB_LICENSE variable is set in your .env file";
    invalid=true;
  else
    checkLicense "$MDCB_LICENSE";
    if $expired; then
      logger "$ERROR" "your MDCB license has expired or is invalid. Please provide another license key";
      invalid=true;
    fi
  fi
fi

if [[ $TYKDP == "$mode" ]]; then
  chart="tyk-hybrid";
  if [[ -z "$TYK_WORKER_CONNECTIONSTRING" ]]; then
    logger "$ERROR" "please make sure TYK_WORKER_CONNECTIONSTRING variable is set in your .env file";
    invalid=true;
  fi
  if [[ -z "$TYK_WORKER_ORGID" ]]; then
    logger "$ERROR" "please make sure TYK_WORKER_ORGID variable is set in your .env file";
    invalid=true;
  fi
  if [[ -z "$TYK_WORKER_AUTHTOKEN" ]]; then
    logger "$ERROR" "please make sure TYK_WORKER_AUTHTOKEN variable is set in your .env file";
    invalid=true;
  fi
  if [[ -z "$TYK_WORKER_SHARDING_ENABLED" ]]; then
    logger "$ERROR" "please make sure TYK_WORKER_SHARDING_ENABLED variable is set in your .env file";
    invalid=true;
  fi
fi

if $invalid; then
  logger "$ERROR" "invalid variables passed to script...";
  exit 1;
fi
