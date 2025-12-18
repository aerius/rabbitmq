#!/bin/bash
set -Eeuo pipefail

# Change current directory to directory of script so it can be called from everywhere
SCRIPT_PATH=$(readlink -f "${0}")
SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
cd "${SCRIPT_DIR}"

: "${DOCKER_BUILD_PLATFORMS:=}"
# If DOCKER_REGISTRY_URL is supplied we should prepend it to the image name
if [[ -z "${DOCKER_REGISTRY_URL:-}" ]]; then
  IMAGE_NAME='aerius-rabbitmq'
else
  IMAGE_NAME="${DOCKER_REGISTRY_URL}/rabbitmq"
fi

# Get version
IMAGE_TAG=$(<VERSION)

BUILDX_BUILD_EXTRA_ARGS=()
[[ "${PUSH_IMAGES:-}" == 'true' ]] && BUILDX_BUILD_EXTRA_ARGS+=('--push')
[[ -n "${DOCKER_BUILD_PLATFORMS}" ]] && BUILDX_BUILD_EXTRA_ARGS+=("--platform=${DOCKER_BUILD_PLATFORMS}")
[[ -z "${DOCKER_BUILD_PLATFORMS}" ]] && BUILDX_BUILD_EXTRA_ARGS+=("--load")

set -x
# Build (and optionally push) image
docker buildx build ${BUILDX_BUILD_EXTRA_ARGS[@]} -t "${IMAGE_NAME}":"${IMAGE_TAG}" docker
