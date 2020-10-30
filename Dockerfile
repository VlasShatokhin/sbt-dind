ARG JDK_VERSION=15.0.1_9

FROM adoptopenjdk/openjdk15:jdk-${JDK_VERSION}-debian-slim

ARG SBT_VERSION=1.4.1

ENV DEBIAN_FRONTEND=noninteractive

# Installing base components 
RUN apt-get update && apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables && \
    apt-get clean autoclean

# Installing sbt
RUN curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get update -qq && apt-get install -y -qq --no-install-recommends \
    sbt && \
    apt-get clean autoclean && \
    sbt sbtVersion -Dsbt.rootdir=true

# Installing docker
RUN curl -sSL https://get.docker.com/ | sh

# Cleanup
RUN rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/*

CMD service docker start && /bin/bash
