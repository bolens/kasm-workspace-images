# Documentation

Kasm desktop image variants, GHCR publication, and operator-managed workspaces.

## Start here

| Need | Owning document |
| --- | --- |
| Use the project | [README.md](../README.md) |
| Change the repository | [AGENTS.md](../AGENTS.md) |
| Deliver or recover | [RELEASING.md](../RELEASING.md) |
| Plan substantial changes | [.specify/memory/project-guide.md](../.specify/memory/project-guide.md) |
| Non-negotiable constraints | [.specify/memory/constitution.md](../.specify/memory/constitution.md) |

## Architecture

The [Arch](../archlinux/Dockerfile), [CachyOS](../cachyos/Dockerfile), and
[Bazzite-style](../bazzite/Dockerfile) build contexts install desktop packages over LinuxServer
KasmVNC bases. The Bazzite-named variant is a Fedora desktop image, not the immutable Bazzite
operating system. Each Dockerfile owns its base and startup script selection.

## Deployment and recovery

[Build and Kasm setup](../README.md) owns operator commands. [RELEASING.md](../RELEASING.md) owns
validation, automatic GHCR publication, and operator-managed Harbor/Kasm boundaries. The
[image workflow](../.github/workflows/images.yml) owns publication triggers and digest promotion.
An output tag does not select the base image or prove
compatibility with a Kasm version. Verify a disposable workspace before promoting the image, and
retain the previous image reference for rollback.

## Database and state

Images contain software, not a repository-owned database. Kasm deployment configuration and
persistent user storage are operator-owned. Rebuilding an image does not back up or restore
workspace data. Keep registry credentials outside image layers and tracked examples.

## Documentation maintenance

Keep decisions, invariants, failure modes, and recovery requirements in the owning document. Link to
commands, defaults, schemas, and generated catalogs instead of copying them. Change the owner and
affected references together. Update this index when adding or moving a guide, and verify relative
links and heading anchors. Historical specs and audits describe their recorded revision, not current
runtime proof. A topic without an implementation stays explicitly unimplemented.

## Topic guides

- [Editor setup](../.vscode/README.md)
- [Development container](../.devcontainer/README.md)
- [License scope and attribution](../THIRD_PARTY_NOTICES.md)
