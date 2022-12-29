## Dockerfile

Here is the Dockerfile:

```Dockerfile
FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN pip install basicsr>=1.4.2 facexlib>=0.2.5 gfpgan>=1.3.5 numpy opencv-python Pillow torchvision tqdm

VOLUME /data

WORKDIR /app

COPY ./Real-ESRGAN .
RUN python setup.py develop 

ENTRYPOINT ["python", "inference_realesrgan.py"]
```

Let's go over it line-by-line.
```Dockerfile
FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime
```
The first line specifies base image that our image inherits. We set it as PyTorch with version 1.9 and for CUDA 8 runtime.

```Dockerfile
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y
```
The 2nd updates package lists and 3rd lines install some binary dependencies for Real-ESRGAN repository.

```Dockerfile
RUN pip install basicsr>=1.4.2 facexlib>=0.2.5 gfpgan>=1.3.5 numpy opencv-python Pillow torchvision tqdm
```
This line install Python libraries that Real-ESRGAN repository depends on with pip.


```Dockerfile
VOLUME /data
```
This line sets a volume for the container that we can attach from host. We use this volume for sharing files between host and the container such as input image files.

```Dockerfile
WORKDIR /app
```
This specifies the working directory in the container. 

```Dockerfile
COPY ./Real-ESRGAN .
RUN python setup.py develop 
```
The first line above copies `Real-ESRGAN` repository to the container and the second line installs it as described in README of `Real-ESRGAN`.

```Dockerfile
ENTRYPOINT ["python", "inference_realesrgan.py"]
```
Finally, the last line sets the entrypoint for the container. We set it as inference script from Real-ESRGAN repo so that the user can run the container with the arguments supported by `inference_realesrgan.py` script.

The Docker image is build with this Dockerfile and `Real-ESRGAN` repository.
```sh
# clone Real-ESRGAN repo
gh repo clone xinntao/Real-ESRGAN
# Build the image with name `real-esrgan`
docker build -t real-esrgan .
```
## Script

Here is the `infer.sh` script.
```sh
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
docker run --rm -v "${workdir}":/data bdsaglam/real-esrgan --fp32 -i "/data/${filename}" -o /data/
```

It contains a utility function `absolute` to convert a filepath to absolute path. This ensures that even if the user provides a relative path for input image, we can get the absolute file path of it. This is necessary as we attach the directory of input image as a volume to the container and Docker doesn't accept relative path for volumes. 

```sh
input_filepath="$(absolute $2)"
workdir="$(dirname ${input_filepath})"
filename="$(basename ${input_filepath})"
```
These lines splits file path of input image into directory and filename.

```sh
docker pull bdsaglam/real-esrgan
```
This pulls the Docker image created with the Dockerfile above from Docker Hub.

```sh
docker run --rm -v "${workdir}":/data bdsaglam/real-esrgan --fp32 -i "/data/${filename}" -o /data
```
The last does a few things. 
- `--rm` flag makes the container deleted after the execution.
- `-v "${workdir}":/data` attaches the directory of input image to the container as a volume at `/data`. 
- `--fp32` makes it use 32-bit floating point so that it's compatible for both CPU and GPU.
- `-i "/data/${filename}"` specifies the file path of input image for the container. Notice that it uses `/data` directory as it's the shared volume between the host and the container.
- `-o /data` specifies the output directory as the shared volume which corresponds to the directory of input image.

The user can use this script with relative or absolute paths of input image:

```sh
chmod +x infer.sh

./infer.sh -i ./cat.jpeg
# or
./infer.sh -i /path/to/cat.jpeg
```