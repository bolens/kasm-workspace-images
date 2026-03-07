# Arch Linux desktop for Kasm Workspaces
# Base: LinuxServer baseimage-kasmvnc (Arch) - Kasm-compatible
ARG KASM_VERSION=1.18.0
FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

USER root

# Install XFCE and common tools
RUN pacman -Sy --noconfirm \
    xfce4 \
    xfce4-goodies \
    ttf-dejavu \
    noto-fonts \
    && pacman -Scc --noconfirm

# Use XFCE as the desktop (replaces default Openbox)
COPY root/defaults/startwm.sh /defaults/startwm.sh
RUN chmod +x /defaults/startwm.sh

USER abc
