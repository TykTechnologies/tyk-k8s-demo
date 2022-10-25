# Check for .env file, if found, load variables
if [[ -f .env ]]; then
  export $(sed -E '/^[A-Za-z_]+=$/d' .env | xargs);
else
  logger $ERROR ".env file not found";
  exit 1;
fi
