# Use Alpine as the base image
FROM debian:latest

# Update and install necessary packages
RUN apt update && apt install -y \
    python3 \
    git \
    emacs \
    curl \
    golang

# Add git 
# Install doom
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs 
RUN yes y | ~/.config/emacs/bin/doom install
# Set up the environment
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

RUN emacs --daemon=default
# Start the container with the command 'emacs'
# CMD ["emacs", "--daemon=default"]
#CMD ["emacs"]
