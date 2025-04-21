FROM docker:28.1

RUN apk update && \
    apk add --no-cache \
    g++ \
    musl-dev \
    python3-dev \
    libffi-dev \
    py3-pip

WORKDIR /app

# Set up a virtual environment and install necessary Python packages
RUN python3 -m venv venv
RUN . venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install awscli dvc dvc[s3]

# Ensure the virtual environment is activated when the container starts
CMD ["/bin/bash", "-c", "source venv/bin/activate && exec ${SHELL:-bash}"]
