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

if [ -z "$images" ]; then
    echo "usage: $0 IMAGE..."
    echo "examples:"
    echo "    $0 dodona-python # only deploy dodona-python image"
    echo "    $0 *             # deploy all images which have a dockerfile in this directory"
    exit 1
fi

for worker in $workers; do
    for img in $images; do
        echo "=== Pulling $img on $worker ==="
        ssh -p 4840 dodona@"$worker" "docker pull $img"
        echo
    done
    echo "=== Pruning old images on $worker ==="
    ssh "$worker" "docker system prune -f"
done


