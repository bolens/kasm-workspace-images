# kasm-workspace-images Spec Kit project guide

Arch Linux, Bazzite, and CachyOS workspace image definitions for Kasm.

Read this guide with `AGENTS.md` and `.specify/memory/constitution.md` before
specifying, planning, or implementing a substantial change. It is project-owned
guidance, not an upstream-managed template.

## Source and ownership map

- `archlinux/Dockerfile`
- `bazzite/Dockerfile`
- `cachyos/Dockerfile`
- `README.md`

## Specification and plan decisions

Name the image variant, base image, build context, startup defaults, package sources,
and registry destination. Explain which behavior is shared and which is variant-
specific. Review user privileges, devices, mounts, and secret boundaries before
implementation.

## Acceptance evidence

Validate Dockerfile and startup-script syntax, build the affected variant, and define a
disposable workspace startup smoke test. Check missing configuration, package failure,
and image metadata without embedding credentials in build arguments or layers.

## Validation and operational limits

```sh
hadolint --failure-threshold error -- */Dockerfile
shellcheck -- */root/defaults/startwm.sh
```

Use the existing pre-push workflow for Buildx checks when the builder is available.
Report unavailable builds instead of calling lint a runtime test. Registry pushes and
Kasm/Harbor changes require explicit publication scope.

## Working through Spec Kit

Use Spec Kit for new capabilities, architectural or security-sensitive changes,
migrations, and coordinated changes that need a written contract. Keep narrow fixes,
dependency updates, and prose maintenance in the normal PR workflow.

For a new feature, record observable acceptance criteria in `spec.md`, source ownership
and constitution checks in `plan.md`, and evidence-bearing work in `tasks.md` under the
feature directory created by Spec Kit. Resolve material unknowns before implementation.
Mark tasks complete only after their stated verification, and distinguish completed,
skipped, blocked, and manual checks. Retain completed feature documents as decision
history; do not backfill feature specifications for already finished code.

Keep `.specify/templates/`, `.specify/scripts/`, and generated Codex skills under their
integration manifests. Use this guide and the constitution for local customization.
Regenerate managed files through Spec Kit and verify that project-owned memory survives
updates. Follow `RELEASING.md` for push, merge, release or delivery, and recovery.
