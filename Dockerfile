# Args
ARG OPENJDK_11_TAG=jre-11.0.8_10-alpine

FROM adoptopenjdk/openjdk11:${OPENJDK_11_TAG}

ARG SBT_VERSION=1.3.13

ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

# Install sbt
RUN apk add --update curl ca-certificates bash && \
    curl -sL "https://piccolo.link/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built && \
    apk del curl

# Caching sbt runtime
RUN sbt sbtVersion

RUN apk add docker

CMD service docker start
