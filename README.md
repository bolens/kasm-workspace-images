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

Build on a host with Docker (no need to build inside Kasm). Choose an output
tag for your registry. The example `1.18.0` tag labels the resulting image; it
does not select a base image or establish compatibility with a Kasm release.

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

The Dockerfiles use the LinuxServer base tags shown in the Images table.
There is no `KASM_VERSION` build argument. Change the relevant `FROM` declaration
and validate that build context when selecting a different base.

## GHCR images

The Workspace images workflow builds all three variants on pull requests.
Changes to image sources on `main`, or a manual run on `main`, publish Linux
amd64 images:

- `ghcr.io/bolens/kasm-workspace-images/archlinux`
- `ghcr.io/bolens/kasm-workspace-images/cachyos`
- `ghcr.io/bolens/kasm-workspace-images/bazzite`

Each image receives a `sha-<full-commit>` tag, source metadata,
build provenance, and an SBOM. The workflow promotes `latest` only after the
published digest passes native-audio loading and a desktop-process smoke test. Use the digest recorded in the workflow summary
when pinning a Kasm workspace. Registry access follows the package visibility
settings; configure Kasm registry credentials for private packages.

## Push to Harbor

Build and push images to your [Harbor](https://goharbor.io/) registry so Kasm (or any host) can pull them.

1. **Create a project in Harbor** (if needed): In the Harbor UI, create a project (e.g. `kasm`) and set it to **Private** or **Public** as you prefer.

2. **Log in to Harbor** from the machine where you build:

   ```bash
   docker login harbor.example.com
   ```
   Use your Harbor username and password (or robot account credentials).

3. **Build and tag for Harbor** (replace `harbor.example.com` and `kasm` with your Harbor host and project):

   ```bash
   export HARBOR=harbor.example.com
   export PROJECT=kasm
   export TAG=1.18.0

   docker build -t $HARBOR/$PROJECT/archlinux-kasm:$TAG -f archlinux/Dockerfile archlinux/
   docker build -t $HARBOR/$PROJECT/cachyos-kasm:$TAG -f cachyos/Dockerfile cachyos/
   docker build -t $HARBOR/$PROJECT/bazzite-kasm:$TAG -f bazzite/Dockerfile bazzite/
   ```

4. **Push to Harbor**:

   ```bash
   docker push $HARBOR/$PROJECT/archlinux-kasm:$TAG
   docker push $HARBOR/$PROJECT/cachyos-kasm:$TAG
   docker push $HARBOR/$PROJECT/bazzite-kasm:$TAG
   ```

   If Harbor uses HTTPS with a self-signed certificate, ensure the Docker daemon trusts it (e.g. add the CA to the host’s trust store or configure Docker’s `insecure-registries` / `registry-config` as needed).

5. **Use in Kasm**: When adding the workspace, set **Image** to e.g. `harbor.example.com/kasm/archlinux-kasm:1.18.0`. For a private project, set **Docker Registry Username** and **Docker Registry Password** to your Harbor user (or robot account) so the Kasm agent can pull.

## Add to Kasm

1. Push images to a registry Docker can pull from (e.g. [Harbor](#push-to-harbor), Docker Hub, GHCR).
2. In Kasm: **Admin** → **Workspaces** → **Add Workspace**.
3. Set **Image** to the full image name and tag (e.g. `harbor.example.com/kasm/archlinux-kasm:1.18.0` or `ghcr.io/myorg/archlinux-kasm:1.18.0`).
4. If the registry is private, set **Docker Registry Username** and **Docker Registry Password**.
5. Configure CPU/memory, zone, and which groups can use the workspace. Save.
6. On the agent, pull the image (or let Kasm install it):  
   `docker exec kasm docker pull <your-image>:<tag>`

## Notes

The inherited s6 entrypoint starts as container root to initialize permissions
and services, then runs the desktop as `abc`. Do not override the image user
with `--user abc`; it prevents `init-adduser` from completing. This does not
require a privileged container. Fedora starts a supervised, container-local system
D-Bus for GNOME and selects the X11 session supplied by KasmVNC; it does not
use the host system bus.

Run `bash scripts/smoke-image IMAGE VARIANT` after a local build. Set
`CONTAINER_ENGINE=podman` to use Podman. The check creates an isolated container
with no network or published ports and removes it and its temporary volumes.

- **CachyOS**: Requires an x86-64-v3 CPU on both the builder and Kasm host.
  The build checks CPU support, installs checksum-pinned keyring and mirrorlist
  packages, and declares the v3 package architecture. Bootstrap versions and
  hashes need manual review against the [official mirror](https://mirror.cachyos.org/repo/x86_64/cachyos/);
  Dependabot monitors the base image and Actions, not these package URLs.
- **Native audio**: Arch and CachyOS use the checksum-pinned official Node
  24.20.0 binary for Kasm's existing PulseAudio addon. The distribution's Node
  upgrade would otherwise change its native-module ABI. Review runtime updates
  against [Node's release checksums](https://nodejs.org/dist/v24.20.0/SHASUMS256.txt);
  this download is not covered by Dependabot. Build and smoke checks require
  the addon to load before an image can be promoted.
- **Arch signing keys**: Arch and CachyOS refresh their signing keyrings before
  the full package upgrade and desktop installation. See the
  [Arch package-signing guidance](https://wiki.archlinux.org/title/Pacman/Package_signing#Upgrade_system_regularly).
- **Bazzite**: This image is a Fedora-based “gaming-style” workspace (e.g. GNOME, common gaming libs). The real [Bazzite](https://bazzite.com/) OS is an immutable Fedora Atomic distro and is not a drop-in Kasm workspace; this Dockerfile approximates a similar environment inside Kasm.
- **LinuxServer bases**: Tags like `arch`, `fedora41` track upstream. Check [releases](https://github.com/linuxserver/docker-baseimage-kasmvnc/releases) for current tags.

### Git hooks

Run `bash scripts/install-git-hooks` once per clone. The pre-commit hook runs fast staged checks; pre-push runs the broader local CI gate.

## License scope and attribution

See [third-party notices](THIRD_PARTY_NOTICES.md) for the project license scope,
retained upstream notices, and dependency or asset exceptions.
