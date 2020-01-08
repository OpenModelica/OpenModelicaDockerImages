
FROM ubuntu:bionic

ARG DISTRO=bionic
ARG VERSION=1.14.1

MAINTAINER Martin Sjölund <martin.sjolund@liu.se>

RUN apt-get update && apt-get upgrade -qy && apt-get dist-upgrade -qy\
    && apt-get install -qy gnupg wget ca-certificates apt-transport-https \
    && echo "deb https://build.openmodelica.org/omc/builds/linux/releases/$VERSION/ $DISTRO release" > /etc/apt/sources.list.d/openmodelica.list \
    && wget https://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - \
    && apt-get update && apt-get upgrade && apt-get dist-upgrade \
    && apt-get install --no-install-recommends -qy omc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
