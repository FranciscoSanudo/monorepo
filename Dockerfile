# Use Alpine as the base image
FROM debian:latest

# Update and install necessary packages
RUN apt update && apt install -y \
    python3 \
    git \
    emacs \
    curl \
    golang \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Add git 
# Install doom
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs 
RUN yes y | ~/.config/emacs/bin/doom install

# Create a virtual environment
# RUN python3 -m venv env

# Activate the virtual environment
#RUN /bin/bash -c "source /home/env/bin/activate"

# Install the required packages within the virtual environment
#RUN pip install flask requests

# Set up the environment
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

RUN emacs --daemon=default
# Start the container with the command 'emacs'
# CMD ["emacs", "--daemon=default"]
#CMD ["emacs"]
