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
    openssh \
    alpine-sdk

RUN wget --no-check-certificate https://github.com/kernix/wkhtmltopdf-docker-alpine/raw/master/wkhtmltopdf -P /usr/bin/
RUN chmod a+x /usr/bin/wkhtmltopdf

ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN gem install bundler --no-ri --no-rdoc
