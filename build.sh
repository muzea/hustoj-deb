#!/bin/sh

VERSION=0.0.1
BUILDDIR="/root/hustoj-${VERSION}"

set -ex \
&& cd / \
&& git clone https://github.com/zhblue/hustoj.git \
&& cd hustoj \
&& git checkout $TRAVIS_TAG \
&& cd /root \
&& git clone https://github.com/muzea/hustoj-deb.git \
# && mv hustoj-deb-ubuntu18 hustoj-${VERSION} \
&& mkdir -p $BUILDDIR \
&& cp -R /root/hustoj-deb/common $BUILDDIR \
&& cp -RT /root/hustoj-deb/${DISTRIBUTION} $BUILDDIR \
&& mv /hustoj/trunk/* $BUILDDIR \
&& cd $BUILDDIR && dpkg-buildpackage \
&& mv /root/hustoj_${VERSION}_amd64.deb /tmp/deb/hustoj_${DISTRIBUTION}_${VERSION}-${TRAVIS_TAG}_amd64.deb
