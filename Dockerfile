# Args
ARG JDK_VERSION=11.0.8

FROM openjdk:${JDK_VERSION}-slim

ARG SBT_VERSION=1.3.13

RUN apt-get update -qq && apt-get install -qqy \
    curl \
    apt-transport-https \
    ca-certificates \
    lxc \
    iptables \
    && rm -rf /var/lib/apt/lists/*

# Install sbt
RUN curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get install sbt

# Caching sbt runtime
RUN sbt sbtVersion

# Install docker
RUN curl -sSL https://get.docker.com/ | sh

CMD service docker start && /bin/bash
