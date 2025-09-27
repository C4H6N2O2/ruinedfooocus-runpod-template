#!/bin/bash
cd /workspace/ruined-fooocus

# RuinedFooocus starten
nohup python entry_with_update.py --listen --port 3000 > /workspace/ruinedfooocus.log 2>&1 &

# RunPod File Uploader starten (Port 2999)
nohup runpod-uploader --port 2999 > /workspace/uploader.log 2>&1 &

# JupyterLab starten (Port 8888, ohne Token)
nohup jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' > /workspace/jupyter.log 2>&1 &

# Container am Leben halten
tail -f /dev/null
