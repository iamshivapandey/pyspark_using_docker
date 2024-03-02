#! /bin/bash

directory="/app/jupyter_home"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    # Directory does not exist, create it
    mkdir -p "$directory"
    echo "-------------------------------->>>Directory created: $directory"
else
    echo "-------------------------------->>>Directory already exists: $directory"
fi


config_file="$HOME/.jupyter/jupyter_server_config.py"
# Check if the configuration file exists
if [ -f "$config_file" ]; then
    :
else
    # If the file doesn't exist, generate configuration and set password
    jupyter server --generate-config -y
    jupyter server password
    if [ -f "$config_file" ]; then
        echo "------------------------------->>>Jupyter Notebook password set successfully."
    fi
fi

if [ -f "$config_file" ]; then
    cd /app/jupyter_home
    jupyter-notebook --ip=0.0.0.0 --no-browser --allow-root
    cd /app
fi
