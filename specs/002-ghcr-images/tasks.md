# Tasks

- [x] Add isolated validation and publication jobs for every workspace variant.
- [x] Document image names, tags, and publication behavior.
- [x] Pass workflow security/syntax and existing source checks.
- [x] Build all variants and smoke-test native audio and desktop startup with
  rootless Podman (Docker socket access was unavailable).
- [ ] Verify a published commit digest after authorized delivery.

All three final local builds and smoke checks passed. Hosted Docker/Buildx runs,
registry publication, and interactive Kasm verification remain separate evidence.
