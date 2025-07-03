# Use the official NVIDIA CUDA image as a base for GPU support
FROM nvidia/cuda:12.1.1-base-ubuntu22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages: curl, python, pip, and supervisor
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install Open WebUI using pip
RUN pip3 install open-webui

# Create directories for supervisor logs and Ollama models
RUN mkdir -p /var/log/supervisor /root/.ollama

# Copy the supervisor configuration file into the image
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy the model pull script into the image and make it executable
COPY pull_model.sh /usr/local/bin/pull_model.sh
RUN chmod +x /usr/local/bin/pull_model.sh

# Expose ports for Open WebUI (8080) and Ollama (11434)
EXPOSE 8080
EXPOSE 11434

# Set the entrypoint to run supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
