# Print Usage for script
usage() {
  echo "Usage:";
  echo "  ./down.sh [flags]";
  echo -e "\nFlags:";
  echo -e "  -v, --verbose   \tbool   \t set log level to debug";
  echo -e "  -n, --namespace \tstring \t namespace the tyk stack will be installed in, defaults to 'tyk'";
  echo -e "  -p, --ports     \tbool   \t disconnect port connections only";
}
