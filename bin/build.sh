#!/bin/bash

set -e
set -x

gem install fury
gem build enc_dashboard.gemspec
fury push --as=moovweb --api-token=$BUNDLE_GEM__FURY__IO *.gem