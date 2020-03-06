#!/bin/sh

workers="
    salmoneu.ugent.be
    sisyphus.ugent.be
    tantalus.ugent.be
    tityos.ugent.be
    ixion.ugent.be
    naos.ugent.be
    "

images=""
for arg in $@; do
    arg="${arg#dodona/}" # strip possible leading 'dodona/'
    arg="${arg%.dockerfile}" # strip possible trailing '.dockerfile'
    if [ "$arg" != "${arg#dodona-}" ]; then # image name starts with "dodona-"
        images="$images dodona/$arg:latest"
    fi
done

for worker in $workers; do
    for img in $images; do
        echo "=== Pulling $img on $worker ==="
        ssh "$worker" "docker pull $img"
        echo
    done
done


