FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
git  cmake g++ libgl1-mesa-dev \
libxrandr-dev libxinerama-dev libxcursor-dev \
libglu1-mesa libglu1-mesa-dev libxi-dev \
libopenmpi-dev python3-dev zlib1g-dev \
python3-pip python3-dev libffi-dev \
wget python3-tk zip libosmesa6-dev patchelf zip

RUN mkdir /root/.mujoco; cd /root/.mujoco; wget https://www.roboti.us/file/mjkey.txt; wget https://www.roboti.us/download/mjpro150_linux.zip; unzip mjpro150_linux.zip; cp mjkey.txt mjpro150/bin/

ENV LD_LIBRARY_PATH = "${LD_LIBRARY_PATH}:/root/.mujoco/mjpro150/bin"

COPY requirements.txt requirements.txt
RUN python3 -m pip install pip==9.0.2
RUN pip install -r requirements.txt
RUN python3 -m pip install opencv-python==4.4.0.42

# specify the working directory for the image
WORKDIR /code
RUN cd /code; git clone https://github.com/EduardoFF/openai_baselines.git; cd openai_baselines; pip install -e .

RUN cd /code; git clone https://github.com/EduardoFF/LearningToFly.git; cd LearningToFly/SimulationUI; mkdir build; cd build; cmake ../; make -j4
