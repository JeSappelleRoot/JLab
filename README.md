# JLab - Custom Jupyter Lab 

Jupyter Lab custom docker image based on base-notebook existing image.
See the different images from the [doc](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html)

## Build

Simply start the docker image build with `docker build -t jlab:latest .`

## Start the container

Then, start the container with :  
```
docker run --name jlab \
-e RESTARTABLE=yes \
-e JUPYTER_ENABLE_LAB=yes \
-e GEN_CERT=yes \
-p 8888:8888 \
-v $PWD/notebooks:/home/jovyan/work \
jlab:latest
```

- `RESTARTABLE=yes` will allow you to restart jupyter lab without shutting down the container  
- `JUPYTER_LAB=yes` start the lab instead of a classic notebook (file exporer, better CSV display...)  
- `GEN_CERT=yes` will enable HTTPS and Jupyter will create a key pair in order to provide SSL/TLS encryption for the webui  
- `-v $PWD/notebooks:/home/jovyan/work` will map local folder with notebooks default location in the container. You will be able to locally save your work !  

> By default, jupyter is running under `jovyan` user.   
> If you want to run some commands with elevated root user or with sudo, you can add `-e GRANT_SUDO=yes --user root`. Then `jovyan` user will be able to run sudo commands

[See basic options for container](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html)  
[See full documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/)

## Add extra Jupyter arguments

You can give to `start-notebook.sh` startup script some extra Jupyter arguments. Then you need to modify the docker run statement : 
```
docker run --name jlab \
-e RESTARTABLE=yes \
-e JUPYTER_ENABLE_LAB=yes \
-e GEN_CERT=yes \
-p 8888:8888 \
-v $PWD/notebooks:/home/jovyan/work \
jlab:latest start-notebook.sh <Jupyter options>
```

- Change the working directory

```
docker run --name jlab \
-e RESTARTABLE=yes \
-e JUPYTER_ENABLE_LAB=yes \
-e GEN_CERT=yes \
-p 8888:8888 \
-v $PWD/notebooks:/home/jovyan/work \
jlab:latest start-notebook.sh --NotebookApp.notebook_dir="/home/jovyan/work"
```

- Specify password to open the web ui (SHA1 format)

```
docker run --name jlab \
-e RESTARTABLE=yes \
-e JUPYTER_ENABLE_LAB=yes \
-e GEN_CERT=yes \
-p 8888:8888 \
-v $PWD/notebooks:/home/jovyan/work \
jlab:latest start-notebook.sh --NotebookApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$xbiVzR/7soNiT8++xD4A4Q$iduvLUaH0/TQzlAn7Dl4ww'
```

> To generate the password use 
```python
import notebook
notebook.auth.passwd('s3cret')

'argon2:$argon2id$v=19$m=10240,t=10,p=8$xbiVzR/7soNiT8++xD4A4Q$iduvLUaH0/TQzlAn7Dl4ww'
```


See all available [options](https://jupyter-notebook.readthedocs.io/en/stable/config.html)

## What's different with this image ? 

### Kernels

The JLab image include :  
- Python kernel (v3.8.8) 
- Powershell kernel (v7.0)
- LaTex support

### Plugins, themes and extensions

The JLab image include some Jupyter plugins : 
- [jupyter-archive](https://github.com/jupyterlab-contrib/jupyter-archive/) to manage archives files from the webui
- [jupyterlab-git](https://github.com/jupyterlab/jupyterlab-git) to manage Git repositories
- [powershell_kernel](https://github.com/vors/jupyter-powershell) to support Powershell 7.0
- [jupyterlab-spellchecker](https://github.com/jupyterlab-contrib/spellchecker) to include a spell checker
- [jupyterlab-lsp](https://github.com/krassowski/jupyterlab-lsp) to provide more IDE functionalities
- [jupyterlab_code_formatter](https://jupyterlab-code-formatter.readthedocs.io/en/latest/index.html) to format code with Black (default formatter)


The JLab image include some extra themes : 

- [JLDracula](https://github.com/dracula/jupyterlab), famous Dracula theme
- [jupyterlab-horizon-theme](https://github.com/mohirio/jupyterlab-horizon-theme), another theme
- [jupyterthemes](https://github.com/dunovank/jupyter-themes), a bundle of themes for the webui
- [jupyterlab_city_lights-theme](https://github.com/yudai-nkt/jupyterlab_city-lights-theme), nother theme

The JLab image include few Jupyter Lab extensions : 
- [jupyterlab-topbar-extension](https://github.com/jtpio/jupyterlab-topbar), to add a customizable top bar
- [jupyterlab-theme-toogle](https://github.com/jtpio/jupyterlab-theme-toggle), to add a switch (dark/light theme) on the top right corner
- [@jupyterlab/toc](https://github.com/jupyterlab/jupyterlab-toc) to generate Markdown table of content

