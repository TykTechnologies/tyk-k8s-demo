VANILLA="vanilla";
OPENSHIFT="openshift";
MONGO="mongo";
POSTGRES="postgres";
REDIS="redis";
REDISCLUSTER="redis-cluster";
REDISSENTINEL="redis-sentinel";
PORTFORWARD="port-forward";
INGRESS="ingress";
LOADBALANCER="load-balancer";
NONE="none";
DEFAULTNAMESPACE="tyk";
AWS="aws";
GCP="gcp";
AZURE="azure";
SSL="SSL";

# Default values
namespace=$DEFAULTNAMESPACE;
redis=$REDISCLUSTER;
storage=$POSTGRES;
isDebug=false;
dryRun=false;
expose=$PORTFORWARD;
cloud=$NONE;
SSLMode=$NONE;
portsWait=15;
deployments=$();

flavor=$VANILLA;
set +e;
search=$(kubectl get service --all-namespaces | grep -e "openshift");
set -e;

if [[ -n $search ]]; then
  logger "$DEBUG" "init-args.sh: openshift detected";
  flavor=$OPENSHIFT;
fi

# Translate long argument flags into short ones.
for arg in "$@"; do
  shift
  case "$arg" in
    '--help')        set -- "$@" '-h'   ;;
    '--verbose')     set -- "$@" '-v'   ;;
    '--namespace')   set -- "$@" '-n'   ;;
    '--flavor')      set -- "$@" '-f'   ;;
    '--expose')      set -- "$@" '-e'   ;;
    '--redis')       set -- "$@" '-r'   ;;
    '--storage')     set -- "$@" '-s'   ;;
    '--deployments') set -- "$@" '-d'   ;;
    '--dry-run')     set -- "$@" '-z'   ;;
    '--cloud')       set -- "$@" '-c'   ;;
    '--ssl')         set -- "$@" '-l'   ;;
    *)               set -- "$@" "$arg" ;;
  esac
done

# Parse short options
OPTIND=1;
while getopts "hvn:f:e:r:s:d:zc:l" opt
do
  case "$opt" in
    'h') usage; exit 0                 ;;
    'v') LOGLEVEL=$DEBUG; isDebug=true ;;
    'n') namespace=$OPTARG             ;;
    'f') flavor=$OPTARG                ;;
    'e') expose=$OPTARG                ;;
    'r') redis=$OPTARG                 ;;
    'z') dryRun=true                   ;;
    'c') cloud=$OPTARG                 ;;
    's') storage=$OPTARG               ;;
    'l') SSLMode=$SSL                  ;;
    'd')
        IFS=',' read -r -a deployments <<< "$OPTARG";
        ;;
    '?') usage; exit 1 ;;
  esac
done
shift $((OPTIND - 1));

if ([[ $VANILLA     != "$flavor"  ]] && [[ $OPENSHIFT    != "$flavor"  ]]) || \
   ([[ $MONGO       != "$storage" ]] && [[ $POSTGRES     != "$storage" ]]) || \
   ([[ $REDIS       != "$redis"   ]] && [[ $REDISCLUSTER != "$redis"   ]]  && [[ $REDISSENTINEL != "$redis"  ]]) || \
   ([[ $PORTFORWARD != "$expose"  ]] && [[ $LOADBALANCER != "$expose"  ]]  && [[ $INGRESS       != "$expose" ]]  && [[ $NONE != "$expose" ]]) || \
   ([[ $AWS         != "$cloud"   ]] && [[ $GCP          != "$cloud"   ]]  && [[ $AZURE         != "$cloud"  ]]  && [[ $NONE != "$cloud" ]]) ; then
  usage; exit 1;
fi
