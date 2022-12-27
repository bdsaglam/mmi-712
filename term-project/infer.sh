#!/bin/bash

# docker run --rm --runtime=nvidia -v "$(pwd)":/data esrgan $@
# docker run --rm  -v "$(pwd)":/data esrgan $@



docker run --rm  -v "$(pwd)":/data --entrypoint=bash -it esrgan 