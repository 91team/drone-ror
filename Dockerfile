FROM ruby:2.4.3-jessie
MAINTAINER Danil Karpov <ushiromia@gmail.com>

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    libgmp3-dev
