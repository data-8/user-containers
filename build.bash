#!/bin/bash

# Builds and pushes a given image to gcr.io + all nodes in current kubectl
# context

set -e

DOCKER_REPO=""

while getopts ":r:" opt; do
	case $opt in
		r) DOCKER_REPO="$OPTARG" ;;
	esac
done
shift $((OPTIND-1))

if [ -z "$1" ]; then
	echo "Usage: $0 [ -r DOCKER_REPO ] [ base | {user_image_type} ]"
	exit 1
fi

# Bail if we're on a dirty git tree
if ! git diff-index --quiet HEAD; then
    echo "You have uncommited changes. Please commit them before building and"
    echo "populating. This helps ensure that all docker images are traceable"
    echo "back to a git commit."
    exit 1
fi

IMAGE="$1"
if [ ! -f ${IMAGE}/Dockerfile ]; then
	echo "No such file: ${IMAGE}/Dockerfile"
	exit 1
fi

kubectl cluster-info | grep -q azure | true
if [ ${PIPESTATUS[1]} -eq 0 ]; then
	DOCKER_PUSH="docker push"
else
	DOCKER_PUSH="gcloud docker -- push"
fi

GIT_REV=$(git log -n 1 --pretty=format:%h -- ${IMAGE})
TAG="${GIT_REV}"

cd ${IMAGE}

if [ -z "${DOCKER_REPO}" ]; then
	IMAGE_SPEC="jupyterhub-k8s-user-${IMAGE}:${TAG}"
	docker build -t ${IMAGE_SPEC} .
	echo "Re-run with '-r DOCKER_REPO' to push to registry."
else
	IMAGE_SPEC="${DOCKER_REPO}/jupyterhub-k8s-user-${IMAGE}:${TAG}"
	docker build -t ${IMAGE_SPEC} .
	${DOCKER_PUSH} ${IMAGE_SPEC}
	echo "Pushed ${IMAGE_SPEC}"
fi
