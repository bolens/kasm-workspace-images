# Bazzite-style (Fedora gaming) desktop for Kasm Workspaces
# Base: LinuxServer baseimage-kasmvnc (Fedora 41). Not the immutable Bazzite OS;
# this is a Fedora-based gaming-style workspace with GNOME.
ARG KASM_VERSION=1.18.0
FROM ghcr.io/linuxserver/baseimage-kasmvnc:fedora41

USER root

# Install GNOME and common gaming/desktop packages (similar stack to Bazzite-style use)
RUN dnf install -y \
    @gnome-desktop \
    gnome-terminal \
    nautilus \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    vulkan-loader \
    ffmpeg \
    && dnf clean all

# Use GNOME as the desktop (replaces default Openbox)
COPY root/defaults/startwm.sh /defaults/startwm.sh
RUN chmod +x /defaults/startwm.sh

USER abc
