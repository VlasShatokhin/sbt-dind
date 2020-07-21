```
JDK_VERSION=11.0.7
SCALA_VERSION=2.13.3
SBT_VERSION=1.3.13

IMAGE_TAG=${JDK_VERSION}_${SCALA_VERSION}_${SBT_VERSION}

docker pull vlasshatokhin/sbt-dind:latest || true
docker build \
    --pull \
    --build-arg SCALA_VERSION=${SCALA_VERSION} \
    --build-arg SBT_VERSION=${SBT_VERSION} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    --cache-from $CI_REGISTRY_IMAGE:latest \
    -t vlasshatokhin/sbt-dind:${IMAGE_TAG} \
    .
docker tag vlasshatokhin/sbt-dind:${IMAGE_TAG} vlasshatokhin/sbt-dind:latest
docker push vlasshatokhin/sbt-dind:latest
```