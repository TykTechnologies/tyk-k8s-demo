DEFAULTNAMESPACE="tyk";
LOGLEVEL=$INFO;

# Default values
namespace=$DEFAULTNAMESPACE;
ports=false;

# Translate long argument flags into short ones.
for arg in "$@"; do
  shift
  case "$arg" in
    '--help')      set -- "$@" '-h'   ;;
    '--verbose')   set -- "$@" '-v'   ;;
    '--namespace') set -- "$@" '-n'   ;;
    '--ports')     set -- "$@" '-p'   ;;
    *)             set -- "$@" "$arg" ;;
  esac
done

# Parse short options
OPTIND=1
while getopts "hvn:p" opt
do
  case "$opt" in
    'h') usage; exit 0     ;;
    'v') LOGLEVEL=$DEBUG   ;;
    'n') namespace=$OPTARG ;;
    'p') ports=true        ;;
    '?') usage; exit 1     ;;
  esac
done
shift $((OPTIND - 1))
