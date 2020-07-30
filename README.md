## sbt + docker

#### Building the image
```sh
OPENJDK_11_TAG=11.0.8
SBT_VERSION=1.3.13

IMAGE_NAME=vlasshatokhin/sbt-dind
IMAGE_TAG=${OPENJDK_11_TAG}_${SBT_VERSION}

docker pull ${IMAGE_NAME}:latest || true
docker build \
    --pull \
    --build-arg SBT_VERSION=${SBT_VERSION} \
    --build-arg OPENJDK_11_TAG=${OPENJDK_11_TAG} \
    --cache-from ${IMAGE_NAME}:latest \
    -t ${IMAGE_NAME}:${IMAGE_TAG} \
    .
docker push ${IMAGE_NAME}:${IMAGE_TAG}
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
docker push ${IMAGE_NAME}:latest
```
