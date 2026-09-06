# GHCR workspace images

Publish the existing Arch Linux, CachyOS, and Fedora gaming workspace variants
as `ghcr.io/bolens/kasm-workspace-images/<variant>` for container consumers.

## Acceptance

- Pull requests build all three Linux amd64 variants without registry credentials.
- Main pushes and manual runs on main publish full commit tags; promote `latest`
  only after the published digest passes the desktop-process smoke check.
- Other branches and forks cannot publish to the maintained namespace.
- Each build uses its variant directory and Dockerfile; native audio must load
  and the desktop must remain running before an image is promoted.
- Include source metadata, build provenance, and SBOMs; pin external actions.
- Serialize publications without cancelling an active publisher.
- Preserve Harbor instructions and existing CI check names.

Full builds and desktop startup require an available Docker daemon. Source lint
must not be reported as successful runtime verification.

Arch keyrings, CachyOS bootstrap inputs and v3 architecture, s6 initialization,
and Fedora system D-Bus must permit these existing desktops to build and start.
