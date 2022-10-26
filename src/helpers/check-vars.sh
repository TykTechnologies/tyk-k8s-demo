source src/helpers/check-license-expiry.sh;

logger $INFO "Checking variables...";

invalid=false;
if [[ $TYKPRO == $mode ]] || [[ $TYKCP == $mode ]]; then

  if [[ -z "$LICENSE" ]]; then
    logger $ERROR "Please make sure the LICENSE variable is set in your .env file";
    invalid=true;
  else
    checkLicense $LICENSE
    if $expired; then
      logger $ERROR "Your Dashboard license has expired or is invalid. Please provide another license key";
      invalid=true;
    fi
  fi
fi

if [[ $TYKCP == $mode ]]; then
  if [[ -z "$MDCB_LICENSE" ]]; then
    logger $ERROR "Please make sure the MDCB_LICENSE variable is set in your .env file";
    invalid=true;
  else
    checkLicense $MDCB_LICENSE;
    if $expired; then
      logger $ERROR "Your MDCB license has expired or is invalid. Please provide another license key";
      invalid=true;
    fi
  fi
fi

if [[ $TYKWORKER == $mode ]]; then
  if [[ -z "$TYK_WORKER_CONNECTIONSTRING" ]]; then
    logger $ERROR "Please make sure TYK_WORKER_CONNECTIONSTRING variable is set in your .env file";
    invalid=true;
  fi
  if [[ -z "$TYK_WORKER_ORGID" ]]; then
    logger $ERROR "Please make sure TYK_WORKER_ORGID variable is set in your .env file";
    invalid=true;
  fi
  if [[ -z "$TYK_WORKER_AUTHTOKEN" ]]; then
    logger $ERROR "Please make sure TYK_WORKER_AUTHTOKEN variable is set in your .env file";
    invalid=true;
  fi
fi

if $invalid; then
  logger $ERROR "Invalid variables passed to script...";
  exit 1;
fi
