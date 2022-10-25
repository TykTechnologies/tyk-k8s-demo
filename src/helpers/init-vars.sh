envs=$(printenv | xargs);

# Default values
TYK_DASHBOARD_VERSION="v4.2.2";
TYK_GATEWAY_VERSION="v4.2.2";
TYK_MDCB_VERSION="v2.0.3";
TYK_PUMP_VERSION="v1.6.0";
TYK_PORTAL_VERSION="v1.0.0";
TYK_HELM_CHART_PATH="tyk-helm";
PASSWORD="topsecretpassword";
TYK_HYBRID_USESSL=true;
TYK_HYBRID_GW_PORT=8081;

# Check for .env file, if found, load variables
if [[ -f .env ]]; then
  export $(sed -E '/^[A-Za-z_]+=$/d' .env | xargs);
else
  logger $INFO ".env file not found";
fi

# Remap environment variables in case they were overridden by the defaults
export $envs;
