applicationSecurityContextUID=1000;
if [[ $OPENSHIFT == "$flavor" ]]; then
  applicationSecurityContextUID="$OS_UID_RANGE";
fi
