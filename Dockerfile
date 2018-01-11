FROM alpine:3.6
MAINTAINER Danil Karpov <ushiromia@gmail.com>

RUN apk add --no-cache ruby=2.4.3-r0 ruby-bundler ruby-dev

RUN apk add --no-cache \
    curl-dev build-base bash \
    cairo-dev postgresql-dev tzdata wget postgresql=9.6.6-r0 \
    gtk+ glib ttf-freefont fontconfig dbus \
    git \
    imagemagick \
    less \
    nodejs \
    nodejs-npm \
    openssh

RUN apk add --update alpine-sdk

ENV LIBV8_VERSION 5.9.211.38.1

RUN set -ex \
    \
    && apk add --update --no-cache --virtual .libv8-builddeps \
      make \
      python \
      git \
      bash \
      curl \
      findutils \
      binutils-gold \
      tar \
      xz \
      linux-headers \
      build-base \
    \
    && git clone -b v$LIBV8_VERSION --recursive git://github.com/cowboyd/libv8.git \
    && cd ./libv8 \
    && sed -i -e 's/Gem::Platform::RUBY/Gem::Platform.local/' libv8.gemspec \
    && gem build --verbose libv8.gemspec \
    && export GYP_DEFINES="$GYP_DEFINES linux_use_bundled_binutils=0 linux_use_bundled_gold=0" \
    && gem install --verbose libv8-$LIBV8_VERSION-x86_64-linux.gem \
    \
    && apk del .libv8-builddeps \
    \
    && cd ../ \
    && rm -rf ./libv8 \
    && cd /usr/local/bundle/gems/libv8-$LIBV8_VERSION-x86_64-linux/vendor/ \
    && mkdir -p /tmp/v8 \
    && mv ./v8/out /tmp/v8/. \
    && mv ./v8/include /tmp/v8/. \
    && rm -rf ./v8 ./depot_tools \
    && mv /tmp/v8 .

RUN wget --no-check-certificate https://github.com/kernix/wkhtmltopdf-docker-alpine/raw/master/wkhtmltopdf -P /usr/bin/
RUN chmod a+x /usr/bin/wkhtmltopdf

ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN gem install bundler --no-ri --no-rdoc
