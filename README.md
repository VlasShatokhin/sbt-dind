## sbt + docker

#### Building the image
```sh
SBT_VERSION=1.3.13

IMAGE_NAME=vlasshatokhin/sbt-dind
IMAGE_TAG=${SBT_VERSION}

docker pull ${IMAGE_NAME}:latest || true
docker build \
    --pull \
    --build-arg SBT_VERSION=${SBT_VERSION} \
    --cache-from ${IMAGE_NAME}:latest \
    -t ${IMAGE_NAME}:${IMAGE_TAG} \
    .
docker push ${IMAGE_NAME}:${IMAGE_TAG}
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
docker push ${IMAGE_NAME}:latest
```
