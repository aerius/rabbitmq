#!/bin/bash
set -Eeuo pipefail

# Change current directory to directory of script so it can be called from everywhere
SCRIPT_PATH=$(readlink -f "${0}")
SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
cd "${SCRIPT_DIR}"

# If DOCKER_REGISTRY_URL is supplied we should prepend it to the image name
if [[ -z "${DOCKER_REGISTRY_URL:-}" ]]; then
  IMAGE_NAME='aerius-rabbitmq'
else
  IMAGE_NAME="${DOCKER_REGISTRY_URL}/rabbitmq"
fi

# Get version
IMAGE_TAG=$(<VERSION)

# Build image
docker build --pull -t "${IMAGE_NAME}":"${IMAGE_TAG}" docker
# Push image if requested
if [[ "${PUSH_IMAGES:-}" == 'true' ]]; then
  echo '# Pushing image'
  docker push "${IMAGE_NAME}":"${IMAGE_TAG}"
fi
