if [[ $TYKSTACK != "$mode" ]] && [[ $TYKCP != "$mode" ]]; then
  logger "$ERROR" "can only apply the keycloak sso integration with a tyk-stack or a tyk-cp installations";
  exit 1;
fi
