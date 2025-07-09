#!/bin/bash

BUILD_TAG=$1

if [ -z "$BUILD_TAG" ]; then
  echo "❌ ERROR: Build tag (argument 1) is required"
  exit 1
fi

echo "🚀 Building Docker image with tag: $BUILD_TAG"
docker build -t keshav4u/nest-app-jenkiens-build:$BUILD_TAG -f ../Dockerfile .

if [ -z "${DOCKER_HUB_USER}" ]; then
  echo "⚠️ Skipping docker push as DOCKER_HUB_USER is not set"
  exit 0
fi

echo "🔐 Logging in to Docker Hub"
echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USER" --password-stdin

echo "📦 Pushing image to Docker Hub"
docker push keshav4u/nest-app-jenkiens-build:$BUILD_TAG