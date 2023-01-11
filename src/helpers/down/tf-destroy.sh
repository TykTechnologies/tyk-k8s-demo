dir=$(pwd);

cd "src/clouds/$cloud";

setVerbose;
if [ "$GCP" == "$cloud" ]; then
  terraform destroy \
    -var "project=$GCP_PROJECT" \
    -var "cluster_location=$CLUSTER_LOCATION" \
    -var "cluster_machine_type=$CLUSTER_MACHINE_TYPE" \
    -auto-approve > /dev/null
else
  terraform destroy \
    -var "cluster_location=$CLUSTER_LOCATION" \
    -var "cluster_machine_type=$CLUSTER_MACHINE_TYPE" \
    -auto-approve > /dev/null
fi
unsetVerbose;

cd "$dir";
