docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/dev:/dev" \
    --device=/dev/nvidiactl \
    --device=/dev/nvidia-uvm \
    --device=/dev/nvidia0 \
    --privileged \
    -p 8898:8888 -p 6016:6006 -p 5910:5900 \
    --name mk_marl_x \
    mk/marl_x
