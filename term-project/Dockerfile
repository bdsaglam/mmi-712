FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN pip install basicsr>=1.4.2 facexlib>=0.2.5 gfpgan>=1.3.5 numpy opencv-python Pillow torchvision tqdm

VOLUME /data

WORKDIR /app

COPY ./Real-ESRGAN .
RUN python setup.py develop 

ENTRYPOINT ["python", "inference_realesrgan.py"]