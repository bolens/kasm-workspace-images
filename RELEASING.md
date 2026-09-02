# Image delivery playbook

Kasm Workspace Images continuously delivers Dockerfiles and workspace metadata
from protected `main`. Image publication is a separate authorized operation;
there are no GitHub version tags.

## Prepare and validate

Branch from current `origin/main`. Review base images, remote package sources,
layers, privileges, devices, ports, and registry destinations. Never pass
credentials through build arguments or persist them in layers. Run repository
hooks and CI-equivalent lint, then build or validate each changed image and run
a representative smoke test when the environment supports it.

## Review, publish, and verify

Require a pull request, all checks, resolved conversations, and a squash merge.
Publishing to a registry requires separate operator authorization. Use an
immutable content/version tag first, retain its digest, scan the result, and
verify Kasm metadata before moving any convenience alias.

## Recover

Do not overwrite a known digest. Stop alias promotion when validation fails.
If a faulty image is public, restore aliases to the last verified digest and
publish a corrected immutable tag. Revoke and rebuild if a secret reached any
layer.

Fleet policy: <https://github.com/bolens/.github/blob/main/RELEASING.md>.
