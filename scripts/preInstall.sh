#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./es_data
chown -R 1000:1000 ./es_data

mkdir -p ./data
chown -R 1000:1000 ./data