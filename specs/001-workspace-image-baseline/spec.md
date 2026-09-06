# Feature specification: Workspace image definitions and desktop startup

**Created**: 2026-09-05
**Status**: Retrospective baseline
**Inspected revision**: `60ffbbe61f6136bf5be99cf1a02e6903dabb37be`
**Input**: The owner requested a fleet-wide Spec Kit retrofit and implementation audit.

Three Docker build contexts extend LinuxServer KasmVNC images with XFCE or GNOME startup. The Fedora variant is a gaming-style workspace, not the immutable Bazzite operating system.

This specification records existing contracts after implementation. It does not
claim that the original work followed Spec Kit. New behavior requires a separate
change contract. Existing feature specifications remain authoritative within their
own scope.

## User scenarios and testing

### User story 1: Build the selected desktop (P1)

An operator selects one documented build context.

**Acceptance**: Each context copies its own startup script, installs its selected desktop, and ends with the unprivileged abc user.

### User story 2: Understand build inputs (P2)

An operator reads the image and build documentation.

**Acceptance**: Documented build arguments actually affect the build; examples distinguish an output tag from the upstream base image.

### User story 3: Deliver source safely (P3)

A maintainer validates the source change.

**Acceptance**: Dockerfile and startup-script checks pass; source delivery does not log into a registry or replace running workspaces.

## Requirements

- **FR-001**: Each build context MUST select its declared LinuxServer base and retain the appropriate desktop startup script.
- **FR-002**: Published build instructions MUST describe effective inputs and MUST NOT present an unused argument as controlling the base image.
- **FR-003**: Image build steps MUST finish as abc and retain executable startup entry points.
- **FR-004**: The Fedora image MUST remain explicitly described as a gaming-style workspace rather than immutable Bazzite.

## Success criteria

- **SC-001**: Every requirement has a named source owner and acceptance check in `coverage.md`.
- **SC-002**: The listed native checks pass for the reviewed candidate, with unavailable environments and operational checks recorded separately.
- **SC-003**: Retrofitting preserves existing interfaces and completed specifications. Any confirmed implementation gap is corrected under an explicit requirement before it is marked complete.

## Edge cases and operational limits

Static Docker build checks do not prove a desktop session starts under a deployed Kasm service. Registry publication and live workspace rollout remain separate operational steps. Base image tags and repository availability are external build inputs, not frozen by a source baseline.
