# Use an official Python runtime as a parent image
FROM python:3.10.12-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Coppying required files and directories
COPY test.py requirements.txt /app/
COPY scripts/ /app/scripts/
COPY jupyter_home/ /app/jupyter_home/
COPY spark/ /app/spark/

# Setting required permissions for file execution
RUN chmod +x /app/scripts/*

# Setting spark home inside docker container
ENV SPARK_HOME=/app/spark
ENV PATH=$PATH:/app/spark/bin

# Installing java for spark
RUN apt-get update && apt-get install -y openjdk-11-jre && \
# Installing required python modules
    pip install --no-cache-dir -r requirements.txt && \
# installing ps service
    apt-get install -y procps && \
# Generate a Jupyter notebook configuration file
    jupyter server --generate-config -y && \
# Generate hashed password and set it in Jupyter configuration
    python -c "from jupyter_server.auth import passwd; print('c.NotebookApp.password = u\'%s\'' % passwd('11111'))" >> /root/.jupyter/jupyter_server_config.py

# Opening a port to connect with services running inside container
EXPOSE 4040 8888

# Run app.py when the container launches
CMD ["python", "test.py"]


