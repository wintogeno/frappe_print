#!/bin/bash

# Step 1: Move into the frappe_docker directory
cd /home/muhammad/Videos/Frappe_client/frappe_docker || { echo "Directory /home/frappe_docker not found!"; exit 1; }

# Step 2: Encode apps.json to base64 and set it as an environment variable
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)
echo $APPS_JSON_BASE64

# Step 3: Run the docker build command
docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=PYTHON_VERSION=3.11.6 \
  --build-arg=NODE_VERSION=18.18.2 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=absolutum/erp-int \
  --file=images/custom/Containerfile .


#docker push absolutm/erp-int:latest

#docker-compose -p pwd -f pwd.yml up
