# Ubuntu22.04

## installation

```
#builds and runs the image, binding your path to the container
```

* To change the docker name, adjust name in `build.sh` file


# Check connection of X-server
```
xeyes
```
* If error occures (e.g., Error: Can't open display: :1), then open new terminal run below command
```
xhost +local:docker
```
