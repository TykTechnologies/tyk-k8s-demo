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

# Default values
namespace=$DEFAULTNAMESPACE;
flavor=$VANILLA;
redis=$REDIS;
storage=$MONGO;
isDebug=false;
dryRun=false;
expose=$NONE;
cloud=$NONE;
portsWait=15;
deployments=$();

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
    *)               set -- "$@" "$arg" ;;
  esac
done

# Parse short options
OPTIND=1;
while getopts "hvn:f:e:r:s:d:zc:" opt
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
    's')
        storage=$OPTARG
        logger "$INFO" "Warning: MDCB installtion does not currently support postgres database";
        ;;
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
