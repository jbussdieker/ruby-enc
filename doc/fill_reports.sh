#!/bin/bash
for version in spec/fixtures/reports/*; do
  for type in changed failed unchanged pending; do
    echo $version/$type.yaml
    curl -XPOST localhost:3000/reports/upload --data-binary @$version/$type.yaml
    echo
  done
done
