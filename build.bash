#!/bin/bash

# Builds and pushes a given image to gcr.io + all nodes in current kubectl
# context

set -e

DOCKER_REPO=$(jq -r '.buildSettings.dockerRepo' 'docker-settings.json')
CLUSTERS=$(jq -r '.clusters | join(" ")' 'docker-settings.json')

if [ -z "$1" ]; then
	echo "Usage: $0 [ base | {user_image_type} ]"
	exit 1
fi

# Bail if we're on a dirty git tree
if ! git diff-index --quiet HEAD; then
    echo "You have uncommited changes. Please commit them before building and"
    echo "populating. This helps ensure that all docker images are traceable"
    echo "back to a git commit."
    exit 1
fi

kubectl cluster-info | grep -q azure | true
if [ ${PIPESTATUS[1]} -eq 0 ]; then
	DOCKER_PUSH="docker push"
else
	DOCKER_PUSH="gcloud docker -- push"
fi

IMAGE="$1"
GIT_REV=$(git log -n 1 --pretty=format:%h -- ${IMAGE})
TAG="${GIT_REV}"

IMAGE_SPEC="${DOCKER_REPO}/jupyterhub-k8s-user-${2}:${TAG}"

if [ ! -f ${IMAGE}/Dockerfile ]; then
	echo "No such file: ${IMAGE}/Dockerfile"
	exit 1
fi

cd ${IMAGE}
docker build -t ${IMAGE_SPEC} .
${DOCKER_PUSH} ${IMAGE_SPEC}

echo "Pushed ${IMAGE_SPEC}"
