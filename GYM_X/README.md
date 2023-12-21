# CUDA + TensorFlow + OpenAI Gym + RoboSchool

## installation

```
#builds and runs the image, binding your path to the container
```

* To change the docker name, adjust name in `build.sh` file

# Requirement
Build CUDA image first (CUDA11.1 is tested)

# Check connection of X-server
```
xeyes
```
* If error occures (e.g., Error: Can't open display: :1), then open new terminal run below command
```
xhost +local:docker
```
