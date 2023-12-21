
# build using squash (this will make the resulting image much smaller)
# docker build --squash -t mk:cuda10.1-ubuntu18.04 .

# original build 
docker build -t mk:cuda11.0-ubuntu18.04 .
