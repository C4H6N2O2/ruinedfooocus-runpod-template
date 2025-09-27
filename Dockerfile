# Basis-Image: CUDA 12.4 + Ubuntu 22.04
FROM nvidia/cuda:12.4.0-devel-ubuntu22.04

# Environment
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# Systempakete
RUN apt-get update && apt-get install -y \
    git wget curl vim python3 python3-pip python3-venv build-essential \
    && rm -rf /var/lib/apt/lists/*

# Python vorbereiten
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN python -m pip install --upgrade pip

# =============================
# PyTorch (CUDA 12.4 Build)
# =============================
RUN pip install --upgrade \
    torch==2.3.0+cu124 torchvision==0.18.0+cu124 torchaudio==2.3.0 \
    --extra-index-url https://download.pytorch.org/whl/cu124

# =============================
# RuinedFooocus installieren
# =============================
RUN git clone https://github.com/runew0lf/RuinedFooocus ruined-fooocus
WORKDIR /workspace/ruined-fooocus
RUN pip install -r requirements_versions.txt

# =============================
# Extras: JupyterLab + FileUploader
# =============================
RUN pip install jupyterlab runpod-file-uploader

# Startup-Skript kopieren
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

WORKDIR /workspace

# Ports: 3000 (RuinedFooocus), 2999 (Uploader), 8888 (JupyterLab)
EXPOSE 3000 2999 8888

CMD ["/workspace/start.sh"]
