if [[ -z "$NEWRELIC_LICENSEKEY" ]]; then
  logger "$ERROR" "Please make sure the NEWRELIC_LICENSEKEY variable is set in your .env file";
  exit 1;
fi
