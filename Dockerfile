FROM adoptopenjdk/openjdk11:debian-slim

ARG SBT_VERSION=1.3.13

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables && \
    apt-get clean autoclean

# Installing java + sbt
RUN curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get update -qq && apt-get install -y -qq --no-install-recommends \
    sbt && \
    apt-get clean autoclean && \
    sbt sbtVersion

# Installing docker
RUN curl -sSL https://get.docker.com/ | sh

# Cleanup
RUN rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/*

CMD service docker start && /bin/bash
