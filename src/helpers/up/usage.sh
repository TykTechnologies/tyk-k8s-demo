# Print Usage for script
usage() {
  echo "Usage:";
  echo "  ./up.sh [flags] [command]";
  echo -e "\nAvailable Commands:";
  echo "  tyk-pro";
  echo "  tyk-cp";
  echo "  tyk-worker";
  echo "  tyk-gateway";
  echo -e "\nFlags:";
  echo -e "  -v, --verbose     \tbool   \t set log level to debug";
  echo -e "      --dry-run     \tbool   \t set the execution mode to dry run. This will dump the kubectl and helm commands rather than execute them";
  echo -e "  -n, --namespace   \tstring \t namespace the tyk stack will be installed in, defaults to 'tyk'";
  echo -e "  -f, --flavor      \tenum   \t k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'";
  echo -e "  -e, --expose      \tenum   \t set this option to 'port-forward' to expose the services as port-forwards or to 'load-balancer' to expose the services as load balancers or 'ingress' which exposes services as a k8s ingress object";
  echo -e "  -r, --redis       \tenum   \t the redis mode that tyk stack will use. This option can be set 'redis', 'redis-sentinel' and defaults to 'redis-cluster'";
  echo -e "  -s, --storage     \tenum   \t database the tyk stack will use. This option can be set 'postgres' and defaults to 'mongo'";
  echo -e "  -d, --deployments \tstring \t comma separated list of deployments to launch";
  echo -e "  -c, --cloud       \tenum   \t stand up k8s infrastructure in 'aws', 'gcp' or 'azure'. This will require Terraform and the CLIs associate with the cloud of choice";
}
