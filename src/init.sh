helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add tyk-helm https://helm.tyk.io/public/helm/charts/
helm repo update

# Check for .env file, if found, load variables
if [ -f .env ]; then
  export $(cat .env | xargs);
else
  echo "Error: .env file not found.";
  exit 1
fi

# Print Usage for script
usage() {
  echo "Usage:";
  echo "  ./poc.sh [flags] [command]";
  echo -e "\nAvailable Commands:";
  echo "  tyk-pro";
  echo "  tyk-cp";
  echo "  tyk-hybrid";
  echo "  tyk-gateway";
  echo -e "\nFlags:";
  echo -e "  -f, --flavor    \tenum  \t k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'";
  echo -e "  -o, --operator  \tbool  \t install the Tyk Operator";
  echo -e "  -p, --portal    \tbool  \t install the Tyk Enterprise Portal";
  echo -e "  -n, --namespace \string \t namespace the tyk stack will be installed in, defaults to 'tyk'";
  exit 1;
}

for arg in "$@"; do
  shift
  case "$arg" in
    '--help')      set -- "$@" '-h'   ;;
    '--flavor')    set -- "$@" '-f'   ;;
    '--operator')  set -- "$@" '-o'   ;;
    '--portal')    set -- "$@" '-p'   ;;
    '--namespace') set -- "$@" '-n'   ;;
    *)            set -- "$@" "$arg" ;;
  esac
done

# Default values
flavor="vanilla";
operator=false;
portal=false;
namespace="tyk";


# Parse short options
OPTIND=1
while getopts "hf:opn:" opt
do
  case "$opt" in
    'h') usage; exit 0     ;;
    'f') flavor=$OPTARG    ;;
    'r') operator=true     ;;
    'p') portal=true       ;;
    'n') namespace=$OPTARG ;;
    '?') usage; exit 1     ;;
  esac
done
shift $((OPTIND - 1))

if [ $flavor != "vanilla" ] && [ $flavor != "openshift" ]; then
  usage;
  exit 1;
fi
