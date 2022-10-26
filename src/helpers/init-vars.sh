# Check for .env file, if found, load variables
if [[ -f .env ]]; then
  file=$(sed -E '/^[A-Z_]+=$/d' .env | xargs);
  env=$(env | sed -E '/^[A-Z_]+=$/d' | xargs)
  export $file;
  export $env;
else
  logger $ERROR ".env file not found";
  exit 1;
fi
