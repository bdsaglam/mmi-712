#!/bin/bash

# converts path to absolute path
absolute() {
    filepath=$1
    echo "$(cd ${filepath%/*}; pwd)/${filepath##*/}"
}

input_filepath="$(absolute $2)"
workdir="$(dirname ${input_filepath})"
filename="$(basename ${input_filepath})"

# pull the image from Dockerhub
docker pull bdsaglam/real-esrgan

# attach directory of input file to the container as volume 
# run in 32-bit floating point mode
docker run --rm -v "${workdir}":/data bdsaglam/real-esrgan --fp32 -i "/data/${filename}" -o /data
