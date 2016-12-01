#!/bin/sh

# clean stale docker images
docker images -q --filter "dangling=true" | xargs docker rmi

# clean stale docker containers
docker ps -a -q | xargs docker rm

ls *.dockerfile | while read dockerfile; do
    name="${dockerfile%.dockerfile}"

    docker build --pull --force-rm -t "$name" -f "$dockerfile" .
done
