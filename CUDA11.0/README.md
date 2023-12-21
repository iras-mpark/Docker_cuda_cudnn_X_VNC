# CUDA 11.0 (with CUDNN 8.0.5) on Ubuntu 18.04 Dockerfile

You need to prepare: 

* A CUDA 11.0 Runfile save it in "cuda" directory (check the readme in cuda folder)
* CUDNN 8.0.5 save it in "cudnn" directory (check the readme in cudnn folder)

You might want to revise the Dockerfile for the filename changes.

* Make backup of daemon.json
`mv /etc/docker/daemon.json /etc/docker/daemon.json_backup`
* Edit `/etc/docker/daemon.json`
\
`
echo $'{\n    "experimental": true\n}' | sudo tee /etc/docker/daemon.json
`
* Run the `sudo systemctl daemon-reload && sudo systemctl restart docker`
* Run the `source build.sh` file to build


* Make backup of daemon.json
`mv /etc/docker/daemon.json /etc/docker/daemon.json_backup1`
* Edit `/etc/docker/daemon.json`
\
`
echo $'{\n
    "runtimes": {\n
        "nvidia": {\n
            "path": "/usr/bin/nvidia-container-runtime",\n
            "runtimeArgs": []\n
        }\n
    }\n
}' | sudo tee /etc/docker/daemon.json
`
* Run the `sudo systemctl daemon-reload && sudo systemctl restart docker`
* Use the `run.sh` file to test run
