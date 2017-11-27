#!/bin/bash

set -e
set -x

gem install fury
gem build end_dashboard.gemspec
fury push --as=moovweb --api-token=$BUNDLE_GEM__FURY__IO *.gem