FROM ruby:2.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG BUNDLE_GEM__FURY__IO=

COPY . /usr/src/app