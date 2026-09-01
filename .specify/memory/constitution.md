# Kasm Workspace Images Constitution

## Core Principles

### I. Reproducible Images
Every workspace image MUST build from reviewed, pinned or deliberately tracked inputs with an explicit base, package set, and build context. Generated images are artifacts, not source.

### II. Least-Privilege Runtime
Images MUST avoid embedded credentials, unnecessary privileges, broad device access, and undocumented network exposure. Desktop convenience MUST NOT weaken container isolation silently.

### III. Small, Layered Variants
Shared setup belongs in common layers and image-specific differences remain local. Variants MUST NOT duplicate large scripts when a tested shared implementation can express the difference.

### IV. Registry and Release Integrity
Tags, registry destinations, and push operations MUST be explicit. Publishing requires operator authorization, successful local validation, and no secrets in layers or build output.

### V. Build and Smoke Verification
Changed images MUST build or have their Dockerfiles/configuration validated and SHOULD receive a representative workspace smoke test. Unsupported environments and skipped builds are reported.

## Governance

README build/publish instructions and Kasm metadata form the user contract. Amendments require security and migration review plus a version update.

**Version**: 1.0.0 | **Ratified**: 2026-08-15 | **Last Amended**: 2026-08-15
