# Args
ARG SCALA_VERSION
ARG SBT_VERSION
ARG JDK_VERSION

# Pull base image
FROM hseeberger/scala-sbt:${JDK_VERSION}_${SBT_VERSION}_${SCALA_VERSION}

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

CMD service docker start && /bin/bash
