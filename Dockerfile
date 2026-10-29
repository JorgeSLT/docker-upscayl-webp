FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    nano \
    iputils-ping \
    ffmpeg \
    libvulkan1 \
    mesa-vulkan-drivers \
    libfontconfig1 \
    libice6 \
    libsm6 \
    libx11-6 \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics

WORKDIR /workspace