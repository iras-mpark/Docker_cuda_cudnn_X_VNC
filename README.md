# Dockerfiles for cuda and cudnn

* CUDA9.0: docker contains cuda9.0 and cudnn7.1
* CUDA10.1: docker contains cuda10.1 and cudnn7.6
* GYM_VNC: docker contains openai gym, jupyter, vnc, tensorflow and pytorch
* GYM_X: docker contains openai gym, xserver, tensorflow, pytorch


1. Install nvidia-docker
	1. Check nouveau & do blacklist it
		1. `lsmod | grep nouveau`
		2. If you can see the list of "nouveau", follow it, if not, ignore it
		3. Create blacklist file
		4. `sudo nano /etc/modprobe.d/blacklist-nouveau.conf `
		5. Writhe under lines
		```
		blacklist nouveau 
		options nouveau modeset=0
		```
		6. `sudo update-initramfs -u `
		7. `sudo service gdm stop `
	2. Install ubuntu driver
		1. `sudo add-apt-repository ppa:graphics-drivers `
		2. `sudo apt-get update `
		3. You can check now the available nvidia-driver version at "software & Updates" app
		4. Move to "Additional Drivers" tap
		5. `sudo apt-get install nvidia-driver-460` (if you want to install "460" version)
		6. `sudo reboot`
		7. After reboot, check installation `nvidia-smi`
	3. Install nvidia-docker (refer. https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
		1. `sudo apt-get update`
		2. `sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common`
		3. Add GPG key and repository
     
     		22.04
     		<pre><code>
  		curl https://get.docker.com | sh && sudo systemctl --now enable docker \
		distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
		&& curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
		&& curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
		</code></pre>
  
    
  		24.04
		<pre><code>
		curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
		&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
		sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
		sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
		</code></pre>
    
   		4. `sudo apt-get update`
   		5. `sudo apt-get install -y nvidia-docker2`
   		6. `sudo systemctl restart docker`
   		7. Finally check installation `sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`
	5. Docker post-installation (refer. https://docs.docker.com/engine/install/linux-postinstall/)
		1. `sudo groupadd docker`
		2. `sudo usermod -aG docker $USER`
		3. Reboot


2. Setup docker for CUDA+JUPYTER+GYM+VNC+TENSORFLOW+PYTORCH
	* Notice, command for remove all images and container 
	```
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	docker rmi $(docker images -q) 
	```
	1. Setup docker which contains cuda11.1 cudnn7.6
	2. Setup docker containing vnc

3. Test an example pytorch code and tensorboard
	1. Let's use jupyter. Open browser (e.g., google chrome) and put `0.0.0.0:8898` on url
	2. Run `example.ipynb`
	3. Check the result on tensorboard
		1. Open new terminal
		2. Execute docker
		```
		docker exec -it mk_gym bash
		```
		3. `cd /notebooks`
		4. `tensorboard --logdir=runs --port 6016 --host=0.0.0.0`
		5. Open new browser and put `0.0.0.0:6016` on url

4. VNC will be used for ROS and Gazebo later (not updated all yet)
	1. Download VNC viewer from https://www.realvnc.com/en/connect/download/viewer/
	2. Install and run it
	3. Put `0.0.0.0:5910` on url
