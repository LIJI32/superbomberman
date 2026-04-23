# Use an official Python runtime as a parent image
FROM ubuntu:latest

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install cc65 from source
RUN git clone https://github.com/cc65/cc65.git /tmp/cc65 && \
    cd /tmp/cc65 && \
    make && \
    make install && \
    rm -rf /tmp/cc65

# Set the working directory
WORKDIR /workspace
