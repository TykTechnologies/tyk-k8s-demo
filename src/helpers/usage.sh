# Print Usage for script
usage() {
  echo "Usage:";
  echo "  ./up.sh [flags] [command]";
  echo -e "\nAvailable Commands:";
  echo "  tyk-pro";
  echo "  tyk-cp";
  echo "  tyk-hybrid";
  echo "  tyk-gateway";
  echo -e "\nFlags:";
  echo -e "  -v, --verbose     \tbool   \t set log level to debug";
  echo -e "      --dry-run     \tbool   \t set the execution mode to dry run. This will dump the kubectl and helm commands rather than execute them";
  echo -e "  -n, --namespace   \tstring \t namespace the tyk stack will be installed in, defaults to 'tyk'";
  echo -e "  -f, --flavor      \tenum   \t k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'";
  echo -e "  -r, --redis       \tenum   \t the redis mode that tyk stack will use. This option can be set 'redis-cluster', 'redis-sentinel' and defaults to 'redis'";
  echo -e "  -s, --storage     \tenum   \t database the tyk stack will use. This option can be set 'postgres' and defaults to 'mongo'";
  echo -e "  -d, --deployments \tstring \t comma separated list of deployments to launch";
}
