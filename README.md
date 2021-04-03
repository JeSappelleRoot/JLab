# JLab - Custom Jupyter Lab 

## Build

Simply start the docker image build with `docker build -t jlab:latest .`

## Start the container

Then, start the container with :  
`docker run --name jlab -e RESTARTABLE=yes -e JUPYTER_ENABLE_LAB=yes -e GEN_CERT=yes -e GRANT_SUDO=yes --user root -p 8888:8888 -v ./notebooks:/home/jovyan/work jlab:latest`  
- `RESTARTABLE=yes` will allow you to restart jupyter lab without shutting down the container  
- `JUPYTER_LAB=yes` start the lab instead of a classic notebook (file exporer, better CSV display...)  
- `GEN_CERT=yes` will enable HTTPS and Jupyter will create a key pair in order to provide SSL/TLS encryption for the webui  
- `-v ./notebooks:/home/jovyan/work` will map local folder with notebooks default location in the container. You will be able to locally save your work !  

> By default, jupyter is running under `jovyan` user.   
> If you want to run some commands with elevated root user or with sudo, you can add `-e GRANT_SUDO=yes --user root`. Then `jovyan` user will be able to run sudo commands


[See basic options for container](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html)  
[See full documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/)

## What's different with this image ? 

### Kernels

The JLab image include :  
- Python kernel 
- Powershell kernel (v7.0)
- LaTex support

### Plugins and extensions

The JLab image include some Jupyter plugins : 
- jupyter-archive to manage archives files from the webui
- jupyterlab-git to manage Git repositories
- JLDracula, famous Dracula theme
- jupyterlab-horizon-theme, another theme
- jupyterthemes, a bundle of themes for the webui
- powershell_kernel to support Powershell 7.0

The JLab image include few Jupyter Lab extensions : 
- jupyterlab-topbar-extension, to add a customizable top bar
- jupyterlab-theme-toogle, to add a switch (dark/light theme) on the top right corner
- jupyterlab_city_lights-theme, another theme

