if [[ -z "$DATADOG_APIKEY" ]]; then
  logger "$ERROR" "Please make sure the DATADOG_APIKEY variable is set in your .env file";
  exit 1;
fi

if [[ -z "$DATADOG_APPKEY" ]]; then
  logger "$ERROR" "Please make sure the DATADOG_APPKEY variable is set in your .env file";
  exit 1;
fi
