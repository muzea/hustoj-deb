FROM debian:8
LABEL maintainer="muzea <mr.muzea@gmail.com>"

RUN set -ex \
    && apt update \
    && apt install git -y \
    && cd / && git clone https://github.com/zhblue/hustoj.git

RUN set -ex \
    && apt install \
               gcc \
               g++ \
               make \
               libmysqlclient-dev \
               libmysql++-dev -y

COPY config.sh /tmp/config.sh
RUN bash /tmp/config.sh install
RUN bash /tmp/config.sh config

RUN apt install build-essential dh-make devscripts dpkg-dev debhelper quilt lintian -y
RUN cd /root && git clone https://github.com/muzea/hustoj-deb.git && mv hustoj-deb hustoj-0.0.1 && mv /hustoj/trunk/* /root/hustoj-0.0.1

