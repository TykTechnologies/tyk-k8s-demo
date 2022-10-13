VANILLA="vanilla";
OPENSHIFT="openshift";
MONGO="mongo";
POSTGRES="postgres";
REDIS="redis";
REDISCLUSTER="redis-cluster";
DEFAULTNAMESPACE="tyk";
LOGLEVEL=$INFO;

# Default values
portal=false;
operator=false;
namespace=$DEFAULTNAMESPACE;
flavor=$VANILLA;
redis=$REDIS;
database=$MONGO;

# Translate long argument flags into short ones.
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

# Parse short options
OPTIND=1
while getopts "hpon:f:r:d:" opt
do
  case "$opt" in
    'h') usage; exit 0     ;;
    'p')
        portal=true;
        logger $INFO "Warning: Portal installtion is only available from the 'add-enterprise-portal'"\
        "branch on the tyk-helm-chart repository and requires the 'TYK_HELM_CHART_PATH'"\
        "value in .env to be set to the local repo location";
        ;;
    'o') operator=true     ;;
    'n') namespace=$OPTARG ;;
    'f') flavor=$OPTARG    ;;
    'r') redis=$OPTARG     ;;
    'd')
        database=$OPTARG
        logger $INFO "Warning: MDCB installtion does not currently support postgres database";
        ;;
    '?') usage; exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if ([[ $VANILLA != $flavor   ]] && [[ $OPENSHIFT    != $flavor   ]]) || \
   ([[ $MONGO   != $database ]] && [[ $POSTGRES     != $database ]]) || \
   ([[ $REDIS   != $redis    ]] && [[ $REDISCLUSTER != $redis    ]]); then
  usage;
  exit 1;
fi
