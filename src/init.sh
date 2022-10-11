# Default values
TYK_DASHBOARD_VERSION=v4.2.1
TYK_GATEWAY_VERSION=v4.2.1
TYK_MDCB_VERSION=v2.0.3
TYK_PUMP_VERSION=v1.6.0
TYK_PORTAL_VERSION=v1.0.0
TYK_HELM_CHART_PATH=tyk-helm
PASSWORD=topsecretpassword

# Check for .env file, if found, load variables
if [ -f .env ]; then
  export $(cat .env | xargs);
else
  echo "Warning: .env file not found.";
fi

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
  echo -e "  -p, --portal    \tbool   \t install the Tyk Enterprise Portal";
  echo -e "  -o, --operator  \tbool   \t install the Tyk Operator";
  echo -e "  -n, --namespace \tstring \t namespace the tyk stack will be installed in, defaults to 'tyk'";
  echo -e "  -f, --flavor    \tenum   \t k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'";
  echo -e "  -r, --redis     \tenum   \t the redis mode that tyk stack will use. This option can be set 'redis-cluster' and defaults to 'redis'";
  echo -e "  -d, --database  \tenum   \t database the tyk stack will use. This option can be set 'postgres' and defaults to 'mongo'";
  exit 1;
}

for arg in "$@"; do
  shift
  case "$arg" in
    '--help')      set -- "$@" '-h'   ;;
    '--portal')    set -- "$@" '-p'   ;;
    '--operator')  set -- "$@" '-o'   ;;
    '--namespace') set -- "$@" '-n'   ;;
    '--flavor')    set -- "$@" '-f'   ;;
    '--redis')     set -- "$@" '-r'   ;;
    '--database')  set -- "$@" '-d'   ;;
    *)             set -- "$@" "$arg" ;;
  esac
done

# Default values
portal=false;
operator=false;
namespace="tyk";
flavor="vanilla";
redis="redis";
database="mongo";

# Parse short options
OPTIND=1
while getopts "hpon:f:r:d:" opt
do
  case "$opt" in
    'h') usage; exit 0     ;;
    'p')
        portal=true;
        echo "Warning: portal installtion is only available from the 'add-enterprise-portal'"\
        "branch on the tyk-helm-chart repository and requires the 'TYK_HELM_CHART_PATH'"\
        "value in .env to be set to the local repo location";
        ;;
    'o') operator=true     ;;
    'n') namespace=$OPTARG ;;
    'f') flavor=$OPTARG    ;;
    'r') redis=$OPTARG     ;;
    'd')
        database=$OPTARG
        echo "Warning: mdcb installtion does not currently support postgres database";
        ;;
    '?') usage; exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if [[ ("vanilla" != $flavor  &&  "openshift" != $flavor) || \
      ("mongo" != $database && "postgres" != $database) || \
      ("redis" != $redis && "redis-cluster" != $redis) ]]; then
  usage;
  exit 1;
fi
