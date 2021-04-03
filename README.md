# JLab - Custom Jupyter Lab 

Simply start the docker image build with `docker build -t jlab:latest .`

Then, start the container with :  
`docker run --name jlab -e RESTARTABLE=yes -e JUPYTER_ENABLE_LAB=yes -e GEN_CERT=yes -e GRANT_SUDO=yes --user root -p 8888:8888 -v ./notebooks:/home/jovyan/work jlab:latest`  
- `RESTARTABLE=yes` will allow you to restart jupyter lab without shutting down the container  
- `JUPYTER_LAB=yes` start the lab instead of a classic notebook (file exporer, better CSV display...)  
- `GEN_CERT=yes` will enable HTTPS and Jupyter will create a key pair in order to provide SSL/TLS encryption for the webui  
- `-v ./notebooks:/home/jovyan/work` will map local folder with notebooks default location in the container. You will be able to locally save your work !  

> By default, jupyter is running under `jovyan` user.   
> If you want to run some commands with elevated root user or with sudo, you can add `-e GRANT_SUDO=yes --user root`. Then `jovyan` user will be able to run sudo commands



