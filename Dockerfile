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

# Create a new user
RUN useradd -ms /bin/bash appuser

# Set the user as the default user
USER appuser

# Set up the environment
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /home/appuser

# Create the appuser's home directory and ensure they have ownership
RUN mkdir -p /home/appuser && chown -R appuser:appuser /home/appuser

# Install 'gotty' in the user's home directory
RUN go install github.com/sorenisanerd/gotty@latest

# Install doom
RUN mkdir -p /home/appuser/.config/emacs
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs /home/appuser/.config/emacs
RUN yes y | /home/appuser/.config/emacs/bin/doom install

# Add the user's bin directory to the PATH
ENV PATH="/home/appuser/go/bin:${PATH}"

# Start the container with the command 'emacs'
CMD ["emacs", "--daemon=default"]
