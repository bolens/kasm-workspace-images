# Custom Kasm Workspace Images

**Source:** [github.com/bolens/kasm-workspace-images](https://github.com/bolens/kasm-workspace-images)

Custom workspace images for [Kasm Workspaces](https://www.kasmweb.com/) (browser-based desktops). These are built on [LinuxServer baseimage-kasmvnc](https://docs.linuxserver.io/images/docker-baseimage-kasmvnc/), which is compatible with Kasm and provides KasmVNC, audio, and the expected user layout.

## Images

| Image      | Base                | Description |
|-----------|---------------------|-------------|
| **archlinux** | `baseimage-kasmvnc:arch` | Arch Linux with XFCE desktop. |
| **cachyos**  | Arch + CachyOS repos | CachyOS (Arch with optimized repos) + XFCE. |
| **bazzite**  | `baseimage-kasmvnc:fedora41` | Fedora-based gaming-style desktop (GNOME). Not the immutable Bazzite OS; a similar stack for Kasm. |

## Build

Build on a host with Docker (no need to build inside Kasm). Use the same tag as your Kasm version where possible (e.g. `1.18.0`).

```bash
git clone https://github.com/bolens/kasm-workspace-images.git
cd kasm-workspace-images

# Arch Linux (XFCE)
docker build -t myregistry/archlinux-kasm:1.18.0 -f archlinux/Dockerfile archlinux/

# CachyOS (Arch + CachyOS repos, XFCE)
docker build -t myregistry/cachyos-kasm:1.18.0 -f cachyos/Dockerfile cachyos/

# Bazzite-style (Fedora gaming)
docker build -t myregistry/bazzite-kasm:1.18.0 -f bazzite/Dockerfile bazzite/
```

Build args (optional):

- `KASM_VERSION` – default `1.18.0`; use the rolling tag for the base image if desired (e.g. `1.18.0-rolling-daily`).

## Add to Kasm

1. Push images to a registry Docker can pull from (Docker Hub, GHCR, or your own).
2. In Kasm: **Admin** → **Workspaces** → **Add Workspace**.
3. Set **Image** to the full image name and tag (e.g. `ghcr.io/myorg/archlinux-kasm:1.18.0`).
4. If the registry is private, set **Docker Registry Username** and **Docker Registry Password**.
5. Configure CPU/memory, zone, and which groups can use the workspace. Save.
6. On the agent, pull the image (or let Kasm install it):  
   `docker exec kasm docker pull <your-image>:<tag>`

## Notes

- **CachyOS**: Uses CachyOS repos for optimized packages; the image is larger and build can take longer.
- **Bazzite**: This image is a Fedora-based “gaming-style” workspace (e.g. GNOME, common gaming libs). The real [Bazzite](https://bazzite.com/) OS is an immutable Fedora Atomic distro and is not a drop-in Kasm workspace; this Dockerfile approximates a similar environment inside Kasm.
- **LinuxServer bases**: Tags like `arch`, `fedora41` track upstream. Check [releases](https://github.com/linuxserver/docker-baseimage-kasmvnc/releases) for current tags.
