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
  echo -e "  -f, --flavor    \tenum   \t k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'";
  echo -e "  -o, --operator  \tbool   \t install the Tyk Operator";
  echo -e "  -p, --portal    \tbool   \t install the Tyk Enterprise Portal";
  echo -e "  -n, --namespace \tstring \t namespace the tyk stack will be installed in, defaults to 'tyk'";
  echo -e "  -d, --database  \tenum   \t database the tyk stack will use. This option can be set 'postgres' and defaults to 'mongo'";
  echo -e "  -r, --redis     \tenum   \t the redis mode that tyk stack will use. This option can be set 'redis-cluster' and defaults to 'redis'";
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
    '--database')  set -- "$@" '-d'   ;;
    '--redis')     set -- "$@" '-r'   ;;
    *)             set -- "$@" "$arg" ;;
  esac
done

# Default values
flavor="vanilla";
operator=false;
portal=false;
namespace="tyk";
database="mongo";
redis="redis";

# Parse short options
OPTIND=1
while getopts "hf:opn:d:r:" opt
do
  case "$opt" in
    'h') usage; exit 0     ;;
    'f') flavor=$OPTARG    ;;
    'o') operator=true     ;;
    'n') namespace=$OPTARG ;;
    'r') redis=$OPTARG     ;;
    'p')
        portal=true;
        echo "Warning: portal installtion is only available from the 'add-enterprise-portal'"\
        "branch on the tyk-helm-chart repository and requires the 'TYK_HELM_CHART_PATH'"\
        "value in .env to be set to the local repo location";
        ;;
    'd')
        database=$OPTARG
        echo "Warning: mdcb installtion does not currently support postgres database";
        ;;
    '?') usage; exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if [ $flavor != "vanilla" ] && [ $flavor != "openshift" ]; then
  usage;
  exit 1;
fi

if [ $database != "mongo" ] && [ $database != "postgres" ]; then
  usage;
  exit 1;
fi

if [ $redis != "redis" ] && [ $redis != "redis-cluster" ]; then
  usage;
  exit 1;
fi
