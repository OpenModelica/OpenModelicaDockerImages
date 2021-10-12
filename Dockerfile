FROM ubuntu:focal

ARG VERSION=1.18.0

MAINTAINER Martin Sjölund <martin.sjolund@liu.se>

RUN export DEBIAN_FRONTEND="noninteractive" && apt-get update && apt-get upgrade -qy && apt-get dist-upgrade -qy\
    && apt-get install -qy gnupg wget ca-certificates apt-transport-https \
    && echo "deb https://build.openmodelica.org/omc/builds/linux/releases/$VERSION/ `cat /etc/lsb-release | grep CODENAME | cut -d= -f2` release" > /etc/apt/sources.list.d/openmodelica.list \
    && wget https://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - \
    && apt-get update && apt-get upgrade && apt-get dist-upgrade \
    && apt-get install --no-install-recommends -qy omc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
