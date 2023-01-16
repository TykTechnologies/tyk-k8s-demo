NONE="none";
DEFAULTNAMESPACE="tyk";
AWS="aws";
GCP="gcp";
AZURE="azure";

# Default values
namespace=$DEFAULTNAMESPACE;
ports=false;
dryRun=false;
isDebug=false;
cloud=$NONE;

# Translate long argument flags into short ones.
for arg in "$@"; do
  shift
  case "$arg" in
    '--help')      set -- "$@" '-h'   ;;
    '--verbose')   set -- "$@" '-v'   ;;
    '--namespace') set -- "$@" '-n'   ;;
    '--ports')     set -- "$@" '-p'   ;;
    '--dry-run')   set -- "$@" '-z'   ;;
    '--cloud')     set -- "$@" '-c'   ;;
    *)             set -- "$@" "$arg" ;;
  esac
done

# Parse short options
OPTIND=1
while getopts "hvn:pzc:" opt
do
  case "$opt" in
    'h') usage; exit 0                 ;;
    'v') LOGLEVEL=$DEBUG; isDebug=true ;;
    'n') namespace=$OPTARG             ;;
    'p') ports=true                    ;;
    'z') dryRun=true                   ;;
    'c') cloud=$OPTARG                 ;;
    '?') usage; exit 1                 ;;
  esac
done
shift $((OPTIND - 1));

if [[ $AWS != "$cloud" ]] && [[ $GCP != "$cloud" ]]  && [[ $AZURE != "$cloud" ]]  && [[ $NONE != "$cloud" ]] ; then
  usage; exit 1;
fi
