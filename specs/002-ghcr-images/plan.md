# Implementation plan

Add `.github/workflows/images.yml` with separate read-only PR builds and a
main-only publication matrix. Use the fleet's verified Docker Action pins,
existing Dependabot monitoring, and variant-specific cache scopes. Publish to
GHCR with the repository token. Repair the build and startup defects identified below.
Update README and RELEASING to document the publication event and image names.

Validation: actionlint, blocking offline zizmor, existing hadolint and shellcheck,
and manual inspection of event/ref/permission behavior. Buildx and workspace
startup remain separate checks when Docker access is available.

## Build failures found during validation

The original Arch build failed package signature checks with its stale keyring.
Refresh the keyring before the full upgrade. CachyOS used obsolete bootstrap
URLs, omitted its v3 mirrorlist, and did not declare the architecture of current
v3 packages. Pin the verified official bootstrap packages by checksum, install
both mirrorlists, and check CPU support before installing v3 packages.

A network-isolated entrypoint probe with the original `USER abc` failed in
`init-adduser` with permission denied. Retain container root for the inherited
s6 initialization; the base starts desktop processes as `abc`.

Fedora GNOME aborted without a system D-Bus. Add a supervised container-local bus
and wait for readiness before launching an explicit X11 desktop session. PRs smoke-test the loaded
image; publication tests the published digest before promoting `latest`.

The Arch/CachyOS upgrade changes Node's native-module ABI. Install the official
Node 24.20.0 binary, verified against its release checksum, for Kasm's existing
native addon. Require the addon to load during the build and smoke test.
