FROM ubuntu:bionic

ARG SBT_VERSION=1.3.13

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -qq -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl

RUN update-ca-certificates

# Installing java + sbt
RUN curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get update -qq && apt-get install -qq -y \
    openjdk-11-jdk \
    sbt

# Caching sbt runtime
RUN sbt sbtVersion

# Installing docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
         $(lsb_release -cs) \
         stable" && \
    apt-get update && apt-get -qq -y install \
        docker-ce

# Cleanup
RUN apt-get remove curl -qq -y && \
    apt-get clean autoclean -qq -y && \
    rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/*

CMD []
