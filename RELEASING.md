# Image delivery playbook

[Documentation](docs/README.md)

Kasm Workspace Images continuously delivers Dockerfiles and workspace metadata
from protected `main`. The Workspace images workflow publishes the three variants
to GHCR when image sources or its workflow change on `main`. A manual run on
`main` rebuilds all variants. There are no GitHub version tags.

## Prepare and validate

Branch from current `origin/main`. Review base images, remote package sources,
layers, privileges, devices, ports, and registry destinations. Never pass
credentials through build arguments or persist them in layers. Run repository
hooks and CI-equivalent lint, then build or validate each changed image and run
a representative smoke test when the environment supports it.

## Push

Follow the [fleet push and merge steps](https://github.com/bolens/.github/blob/main/RELEASING.md#push-and-merge).
After the local checks pass, inspect the diff, commit focused changes, and push
only the feature branch to the GitHub remote:

```sh
git push --set-upstream origin HEAD
```

Confirm `origin` points to `bolens/kasm-workspace-images` on GitHub before pushing.
Do not push `main`, force-push, skip failing hooks, or bypass protection.

## Review, publish, and verify

Require a pull request, all checks, resolved conversations, and a squash merge.
Merging an image or publishing-workflow change activates GHCR publication.
PR builds have read-only permissions; only this repository's main pushes and
manual main runs receive GHCR credentials. The workflow publishes commit tags with provenance and an SBOM, smoke-tests
the published digest, and promotes `latest` only after the desktop remains ready.
It records each digest. Verify the intended desktop interaction before selecting
it in Kasm. Harbor pushes
and changes to deployed workspaces remain separate operator actions.

## Recover

Do not overwrite a known digest. Stop alias promotion when validation fails.
If a faulty image is public, restore aliases to the last verified digest and
publish a corrected immutable tag. Revoke and rebuild if a secret reached any
layer.

Fleet policy: <https://github.com/bolens/.github/blob/main/RELEASING.md>.

## Woodpecker validation

[The transition contract](docs/woodpecker-transition.md) adds portable Linux
checks alongside existing host validation. Require actual native PR and main
success before retiring duplicates. Existing platform, security, packaging and
publishing authorities remain in place. This CI change creates no source Git tag
or product version bump. Normal main-branch image publication continues when
image sources or the publishing workflow change.

The native `workflow-policy` group calls
`bash scripts/ci/check-workflow-policy.sh` for checksum-verified actionlint
1.7.12 and offline zizmor 1.29.0 at medium severity/confidence. Workflow lint now retains only scheduled/manual execution after exact-head PR and genuine-main verification. The
[CI index](docs/woodpecker-transition.md#ci-organization) preserves the separate
normal pre-push Buildx checks, full image builds, desktop smoke tests and GHCR
publication authority. Static policy success does not replace those checks.

## Managed integration validation

`bash scripts/ci/check-spec-kit.sh` verifies the current Spec Kit manifests and
managed files without updating them. The existing native repository-policy
command, `bash scripts/ci/check-workflow-policy.sh`, includes this check in its existing
container and status context. It downloads only the public validator at
`bolens/.github@c161a6757130ea687def9eb1e81c6a4190488f07`, verifies its
SHA-256, limits the download to 64 KiB and 60 seconds, and bounds validation to
four minutes. Local reproduction needs Bash and Python 3 on Linux/macOS with
HTTPS access. It uses temporary files and requires no secrets or installed skill links.

Source/workflow policy now runs in Woodpecker; duplicate GitHub policy workflows
retain scheduled/manual execution after their verified cutover. The mixed
Spec Kit workflow still runs its hosted read-only PR/push validation while this
native integration is qualified on actual PR and genuine-main revisions. Its
scheduled/manual updater remains on GitHub. Preserve all current check names and
publication/platform boundaries during that qualification.
