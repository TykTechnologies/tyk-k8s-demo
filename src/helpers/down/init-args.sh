DEFAULTNAMESPACE="tyk";

# Default values
namespace=$DEFAULTNAMESPACE;
ports=false;
dryRun=false;
isDebug=false;

# Translate long argument flags into short ones.
for arg in "$@"; do
  shift
  case "$arg" in
    '--help')      set -- "$@" '-h'   ;;
    '--verbose')   set -- "$@" '-v'   ;;
    '--namespace') set -- "$@" '-n'   ;;
    '--ports')     set -- "$@" '-p'   ;;
    '--dry-run')   set -- "$@" '-z'   ;;
    *)             set -- "$@" "$arg" ;;
  esac
done

# Parse short options
OPTIND=1
while getopts "hvn:pz" opt
do
  case "$opt" in
    'h') usage; exit 0                 ;;
    'v') LOGLEVEL=$DEBUG; isDebug=true ;;
    'n') namespace=$OPTARG             ;;
    'p') ports=true                    ;;
    'z') dryRun=true                   ;;
    '?') usage; exit 1                 ;;
  esac
done
shift $((OPTIND - 1));
