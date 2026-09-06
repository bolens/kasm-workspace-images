# syntax=docker/dockerfile:1
# Arch Linux desktop for Kasm Workspaces
# Base: LinuxServer baseimage-kasmvnc (Arch) - Kasm-compatible
FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

USER root

# Install XFCE and common tools
RUN pacman -Sy --noconfirm archlinux-keyring \
    && pacman -Su --noconfirm \
    xfce4 \
    xfce4-goodies \
    ttf-dejavu \
    noto-fonts \
    && pacman -Scc --noconfirm

# Keep Kasm's native audio addon on its supported Node 24 ABI.
ADD --checksum=sha256:2f2c0da162318f0de47665410c7c8c2ed3d36c8f3105de4bbc61176c70a7cbf2 \
    https://nodejs.org/dist/v24.20.0/node-v24.20.0-linux-x64.tar.xz /tmp/kasm-node.tar.xz
RUN tar -xJf /tmp/kasm-node.tar.xz --no-same-owner --strip-components=2 \
        -C /usr/local/bin node-v24.20.0-linux-x64/bin/node \
    && rm /tmp/kasm-node.tar.xz \
    && node -e "require('/kclient/node_modules/pulseaudio2')"

# Use XFCE as the desktop (replaces default Openbox)
COPY root/defaults/startwm.sh /defaults/startwm.sh
RUN chmod +x /defaults/startwm.sh

# The base s6 init needs root to initialize ownership, then starts the desktop as abc.
USER root
