run_as_user=1000;
fs_group=2000;
if [[ $OPENSHIFT == "$flavor" ]]; then
  run_as_user="$OS_UID_RANGE";
  fs_group="$OS_UID_RANGE";
fi
