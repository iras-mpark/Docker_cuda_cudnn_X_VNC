# CUDA + TensorFlow + OpenAI Gym + RoboSchool + Jupyter

## Build Docker container
```
#builds and runs the image, binding your path to the container, so you can access them from jupyter
./build.sh
```

* To change the docker name, adjust name in `build.sh` file

# Requirement
Build CUDA image first (CUDA11.1 is tested)

# Install VNC viewer
Case 1. Own Ubuntu (Remmina)
```
sudo apt install remmina -y 
```
Case 2. Remote Windows (RealVNC)

# Connect via VNC viewer
Case 1. Own Ubuntu (0.0.0.0:5900)

Case 2. Remote Windows (UBUNTU IP:5900)
