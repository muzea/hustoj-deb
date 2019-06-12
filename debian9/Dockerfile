FROM debian:9
LABEL maintainer="muzea <mr.muzea@gmail.com>"

RUN set -ex \
    && apt update \
    && apt install git -y

RUN set -ex \
    && apt install \
               gcc \
               g++ \
               make \
               libmysqlclient-dev \
               libmysql++-dev -y

COPY build.sh /root/build.sh

RUN apt install build-essential dh-make devscripts dpkg-dev debhelper quilt lintian -y
