#!/bin/bash

absolute() {
    PATH=$1
    echo "$(cd ${PATH%/*}; pwd)/${PATH##*/}"
}

echo $@

abs_path="$(absolute $2)"
workdir="$(dirname ${abs_path})"
filename="$(basename ${abs_path})"
echo $workdir
echo $filename

docker run --rm  -v "$(pwd)":/data --entrypoint=bash -it esrgan 