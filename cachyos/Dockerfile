# CachyOS (Arch + optimized repos) desktop for Kasm Workspaces
# Base: LinuxServer baseimage-kasmvnc (Arch), then add CachyOS repos
ARG KASM_VERSION=1.18.0
FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

USER root

# Add CachyOS repository key and repo
RUN pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com \
    && pacman-key --lsign-key F3B607488DB35A47

# Install CachyOS keyring and mirrorlist (from Arch repo or CachyOS bootstrap)
RUN curl -sL "https://mirror.cachyos.org/cachyos/cachyos-keyring-2-1-any.pkg.tar.zst" -o /tmp/cachyos-keyring.pkg.tar.zst \
    && curl -sL "https://mirror.cachyos.org/cachyos/cachyos-mirrorlist-28-1-any.pkg.tar.zst" -o /tmp/cachyos-mirrorlist.pkg.tar.zst \
    && pacman -U --noconfirm /tmp/cachyos-keyring.pkg.tar.zst /tmp/cachyos-mirrorlist.pkg.tar.zst \
    && rm /tmp/cachyos-keyring.pkg.tar.zst /tmp/cachyos-mirrorlist.pkg.tar.zst

# Add CachyOS repos above [core] in pacman.conf (CachyOS packages take precedence)
RUN sed -i '/\[core\]/i \[cachyos\]\nInclude = /etc/pacman.d/cachyos-mirrorlist\n\n[cachyos-v3]\nInclude = /etc/pacman.d/cachyos-v3-mirrorlist\n\n' /etc/pacman.conf

# Sync and install XFCE (use CachyOS/Arch packages)
RUN pacman -Sy --noconfirm \
    xfce4 \
    xfce4-goodies \
    ttf-dejavu \
    noto-fonts \
    && pacman -Scc --noconfirm

# Use XFCE as the desktop
COPY root/defaults/startwm.sh /defaults/startwm.sh
RUN chmod +x /defaults/startwm.sh

USER abc
