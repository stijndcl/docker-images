#!/bin/sh

ls *.dockerfile | while read dockerfile; do
    name="${dockerfile%.dockerfile}"

    docker build -t "$name" -f "$dockerfile" .
done
