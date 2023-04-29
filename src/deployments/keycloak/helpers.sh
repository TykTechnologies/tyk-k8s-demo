checkKeycloakRealmImportCRExists() {
  set +e;
  search=$(kubectl get KeycloakRealmImport --namespace "$namespace" | awk '{print $1}' | grep -e "^$1$");
  logger "$DEBUG" "checkKeycloakRealmImportCRExists: search result $search";
  set -e;

  keycloakRealmImportCRExists=true;
  if [[ -z $search ]]; then
    keycloakRealmImportCRExists=false;
  fi
}
