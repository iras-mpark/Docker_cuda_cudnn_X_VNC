docker build -t mk/marl_vnc ./
docker run --name mk_marl_vnc -e NB_UID=1000 -e NB_GID=1000 -e VNC_SERVER_PASSWORD=password -p 8888:8888 -p 6006:6006 -p 5900:5900  mk/marl_vnc
#nvidia-docker run -d --name marl_mk -e NB_UID=1000 -e NB_GID=1000 -e VNC_SERVER_PASSWORD=password -p 8898:8888 -p 6016:6006 -p 5910:5900  mk/marl

echo "build succeeded, wait a bit for X to start, then getting the jupyter notebook URL with token"
sleep 3
docker exec -it mk_marl_vnc bash -c "jupyter notebook list"
