FROM jupyter/base-notebook:latest

# Switch to root user
USER root

# Install PowerShell 7
RUN apt-get update && apt-get install -y wget git nodejs apt-transport-https software-properties-common \
&& wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& rm packages-microsoft-prod.deb \
&& apt-get update && add-apt-repository universe && apt-get install -y powershell

# Switch to Jupyter dedicated user
USER jovyan

# Install Jupyter plugins
RUN pip install --no-cache-dir \
jupyter-archive \
jupyterlab-git \
JLDracula \
jupyterlab-horizon-theme \
jupyterthemes \
jupyterlab-spellchecker \
jupyterlab-lsp \
"python-language-server[all]" \
jupyterlab_code_formatter \
black \
powershell_kernel

# Finalize PowerShell Jupyter kernel installation
RUN python -m powershell_kernel.install

# Install LSP language servers
RUN npm install --save-dev \
yaml-language-server \
vscode-json-languageserver-bin \
unified-language-server \
dockerfile-language-server-nodejs \
bash-language-server \
&& npm cache clean --force


# Install Jupyter Lab extensions
RUN jupyter labextension install --no-build \
jupyterlab-topbar-extension \
jupyterlab-theme-toggle \
@yudai-nkt/jupyterlab_city-lights-theme \
@jupyterlab/toc \
jupyterlab_onedarkpro \
jupyterlab-tailwind-theme \
@yeebc/jupyterlab_neon_theme \
@konodyuk/theme-ayu-mirage

# Add LaTex support
# Fix found in GitHub
# https://github.com/jupyterlab/jupyterlab-latex/issues/154
# https://github.com/jupyterlab/jupyterlab-latex/blob/master/docs/advanced.md
RUN git clone https://github.com/joequant/jupyterlab-latex.git && \
cd jupyterlab-latex \
&& pip install -e . \
&& jlpm install \
&& jlpm run build \
&& jupyter labextension install . --no-build \
&& cd .. && rm -r jupyterlab-latex

# Final Jupyter lab build to include installed extensions
RUN jupyter lab build
