checkCommand terraform;

dir=$(pwd);

cd "src/clouds/$cloud";

enable_cloud_redis=false;
enable_cloud_storage=false;
if [ "$redis" == "$CLOUD" ]; then
    enable_cloud_redis=true;
fi
if [ "$storage" == "$CLOUD" ]; then
    enable_cloud_storage=true;
fi

setVerbose;
if [ "$AWS" == "$cloud" ]; then
  terraform init > /dev/null
  terraform get > /dev/null
  terraform apply \
    -var "cluster_location=$CLUSTER_LOCATION" \
    -var "cluster_machine_type=$CLUSTER_MACHINE_TYPE" \
    -var "cluster_node_count=$CLUSTER_NODE_COUNT" \
    -var "enable_cloud_redis=$enable_cloud_redis" \
    -var "enable_cloud_storage=$enable_cloud_storage" \
    -auto-approve > /dev/null

  aws eks update-kubeconfig \
    --region "$CLUSTER_LOCATION" \
    --name "tyk-demo-$CLUSTER_LOCATION" > /dev/null

elif [ "$GCP" == "$cloud" ]; then
  terraform init > /dev/null
  terraform apply \
    -var "project=$GCP_PROJECT" \
    -var "cluster_location=$CLUSTER_LOCATION" \
    -var "cluster_machine_type=$CLUSTER_MACHINE_TYPE" \
    -var "cluster_node_count=$CLUSTER_NODE_COUNT" \
    -var "enable_cloud_redis=$enable_cloud_redis" \
    -var "enable_cloud_storage=$enable_cloud_storage" \
    -auto-approve > /dev/null

  gcloud container clusters get-credentials "tyk-demo-$CLUSTER_LOCATION" \
    --zone="$CLUSTER_LOCATION" > /dev/null

elif [ "$AZURE" == "$cloud" ]; then
  terraform init > /dev/null
  terraform apply \
    -var "cluster_location=$CLUSTER_LOCATION" \
    -var "cluster_machine_type=$CLUSTER_MACHINE_TYPE" \
    -var "cluster_node_count=$CLUSTER_NODE_COUNT" \
    -var "enable_cloud_redis=$enable_cloud_redis" \
    -var "enable_cloud_storage=$enable_cloud_storage" \
    -auto-approve > /dev/null

  az aks get-credentials \
    --resource-group "tyk-demo-$CLUSTER_LOCATION" \
    --name "tyk-demo-$CLUSTER_LOCATION" > /dev/null
fi
unsetVerbose;

cd "$dir";
