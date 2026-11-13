# Woodpecker validation

Validate all three maintained Dockerfiles with the same pinned Hadolint image as GitHub, then lint startup scripts with ShellCheck.

## CI organization

The [shared purpose phases](https://github.com/bolens/.github/blob/main/docs/woodpecker-transition.md#ci-organization)
map the existing checks and image owners. Keep the three variant contexts
`archlinux`, `bazzite` and `cachyos` explicit when reproducing an image check.

| Phase | Check group / canonical local command | Native workflow / step | Retained hosted owner / boundary |
| --- | --- | --- | --- |
| `validate` | Dockerfile lint: `hadolint --failure-threshold error -- */Dockerfile` | `woodpecker` / `dockerfiles` | PR, main push and native manual validation; fixed maintained file scope |
| `validate` | Startup scripts: `shellcheck -- */root/defaults/startwm.sh bazzite/root/custom-services.d/dbus scripts/smoke-image` | `woodpecker` / `startup-scripts` | Static shell checks, without starting a workspace |
| `validate` | Workflow policy: `bash scripts/ci/check-workflow-policy.sh` | `woodpecker` / `workflow-policy` | actionlint 1.7.12 and offline zizmor 1.29.0. Duplicate hosted Workflow lint is disabled after verified native cutover |
| `validate` | Managed Spec Kit integrity: `bash scripts/ci/check-spec-kit.sh` (included in repository policy) | Existing policy step | Immutable C161 validator. Automatic PR/main validation is native. Hosted manual validation and scheduled/manual updater stay active |
| `test` | Buildx checks: `docker buildx build --check --file archlinux/Dockerfile archlinux`, repeated for `bazzite` and `cachyos` | Separate from native lint | Existing pre-push hook requires a builder; hosted Workspace images performs real builds |
| `test` | Desktop startup: `bash scripts/smoke-image IMAGE VARIANT` after building the selected image | Separate from native lint | Hosted Workspace images checks the Node ABI and desktop readiness in disposable network-isolated containers |
| `publish` | Existing image procedure in [RELEASING](../RELEASING.md) | Publication stays with its existing owner | Trusted main pushes for image/workflow changes or manual main runs publish GHCR digests and promote aliases after smoke checks; PR builds remain read-only |

`IMAGE` is the built image reference and `VARIANT` is one of the three names
above. Registry publication and deployed Kasm changes retain their separate
authorization. The existing native identity and hosted release dependencies
remain stable.

The pipeline runs on pull requests and main pushes with immutable clone/runtime
images. It has no host mounts, Docker socket, privileged mode or publishing
secrets. Package installation is confined to the disposable job container.
Existing GitHub checks remain during native verification. Platform, real Docker,
security and release checks remain separate until equivalent coverage exists.
A container or lint result does not prove installation, runtime or publication.

Require exact-head PR checks, a reviewed squash merge, and genuine native main
success before retiring duplicates. Keep existing required status names until
their replacements have passed and host settings agree. Recover through a
corrective PR without changing live profiles or installations.

Review image digests monthly and after security releases. Existing Dockerfile
updaters do not monitor these Woodpecker YAML references. Direct tool pins and
image updates require a reviewed PR and successful native execution.

The workflow-policy group matches the retained shared actionlint workflow: version
1.7.12 with its recorded SHA-256 archive checksum, and zizmor 1.29.0 with offline
audits at medium severity and confidence. Local reproduction requires Git, curl,
Python 3 with venv support and ShellCheck; downloaded tools use a disposable
temporary directory. Apt installation belongs only to the CI container step.
The new group validates workflow source; it does not execute Buildx, start a
workspace, push an image, or replace the retained image/publishing requirements.
Workflow lint retirement followed actual native PR and genuine-main proof. The
duplicate hosted workflow is disabled, including manual and scheduled execution.
Its tracked source remains available for rollback.
