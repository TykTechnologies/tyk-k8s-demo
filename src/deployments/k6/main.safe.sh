if [ -z "$k6Registered" ]; then
  k6Registered=true;
  source "src/deployments/k6/main.sh";
fi
