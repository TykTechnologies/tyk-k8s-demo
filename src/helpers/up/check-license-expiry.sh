decode_jwt () { _decode_base64_url $(echo -n "$1" | cut -d "." -f ${2:-2}) | jq .; }
_decode_base64_url () {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}

checkLicense() {
  exp=$(decode_jwt "$1" | jq -r '.exp');
  now=$(date '+%s');

  if [[ "$(expr $exp - $now)" -le "0" ]]; then
    expired=true;
  else
    expired=false;
  fi
}
