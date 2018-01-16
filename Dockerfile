FROM ruby:2.3.6-jessie
MAINTAINER Danil Karpov <ushiromia@gmail.com>

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    libgmp3-dev
