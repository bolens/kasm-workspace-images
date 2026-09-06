# syntax=docker/dockerfile:1
# CachyOS (Arch + optimized repos) desktop for Kasm Workspaces
# Base: LinuxServer baseimage-kasmvnc (Arch), then add CachyOS repos
FROM ghcr.io/linuxserver/baseimage-kasmvnc:arch

USER root

# Add CachyOS repository key and repo
RUN pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com \
    && pacman-key --lsign-key F3B607488DB35A47

# Bootstrap inputs from the official optimized-repository installation guide.
# Verify new hashes against the official mirror when updating these versions.
ADD --checksum=sha256:a0df7a06ddd0f315b46ca9353886f786922083d0a4a4502e440473005a20d6a4 \
    https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst \
    /tmp/cachyos-keyring.pkg.tar.zst
ADD --checksum=sha256:69c6a033d45ecc105f632dcdc41528d0a2c84c927df0e2728bee2a8bd22d2015 \
    https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-27-1-any.pkg.tar.zst \
    /tmp/cachyos-mirrorlist.pkg.tar.zst
ADD --checksum=sha256:bce9178b60daf6cae1892cc8bd21603443a92352f3d5bc231465e157dc269207 \
    https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-27-1-any.pkg.tar.zst \
    /tmp/cachyos-v3-mirrorlist.pkg.tar.zst
RUN pacman -U --noconfirm /tmp/cachyos-keyring.pkg.tar.zst \
    /tmp/cachyos-mirrorlist.pkg.tar.zst /tmp/cachyos-v3-mirrorlist.pkg.tar.zst \
    && rm /tmp/cachyos-*.pkg.tar.zst

# Add CachyOS repos above [core] in pacman.conf (CachyOS packages take precedence)
RUN /lib/ld-linux-x86-64.so.2 --help | grep -q 'x86-64-v3 (supported'
RUN sed -i 's/^Architecture[[:space:]]*=.*/Architecture = x86_64 x86_64_v3/' /etc/pacman.conf \
    && sed -i '/\[core\]/i \[cachyos\]\nInclude = /etc/pacman.d/cachyos-mirrorlist\n\n[cachyos-v3]\nInclude = /etc/pacman.d/cachyos-v3-mirrorlist\n\n' /etc/pacman.conf

# Sync and install XFCE (use CachyOS/Arch packages)
RUN pacman -Sy --noconfirm archlinux-keyring cachyos-keyring \
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

# Use XFCE as the desktop
COPY root/defaults/startwm.sh /defaults/startwm.sh
RUN chmod +x /defaults/startwm.sh

# The base s6 init needs root to initialize ownership, then starts the desktop as abc.
USER root
