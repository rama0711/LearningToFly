#IMAGE=ubuntu:16.04
IMAGE=learning_to_fly
CMD=/bin/bash

docker run -it  \
       --env="DISPLAY" \
       --env="QT_X11_NO_MITSHM=1" \
       --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
       --net="host" \
       --privileged \
       --rm \
       --name learning_to_fly \
       --volume $(pwd):/usr/src/app \
       $IMAGE \
       $CMD
