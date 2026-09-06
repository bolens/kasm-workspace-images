# Image delivery playbook

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
