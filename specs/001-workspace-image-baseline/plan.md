# Plan: Workspace image definitions and desktop startup

The [specification](spec.md) preserves existing behavior. Use the project guide
and constitution for implementation constraints. Keep upstream-managed templates,
helpers, and integration manifests unchanged.

## Source ownership

- `archlinux/Dockerfile`
- `cachyos/Dockerfile`
- `bazzite/Dockerfile`
- `archlinux/root/defaults/startwm.sh`
- `cachyos/root/defaults/startwm.sh`
- `bazzite/root/defaults/startwm.sh`
- `README.md`

## Constitution check

Preserve per-image ownership, non-root runtime identity, accurate compatibility claims, and separation of source validation from registry publication or deployment.

## Validation

```sh
bash .githooks/pre-push
```

Run checks in an isolated checkout. Commands are instructions, not evidence of
a pass. Record results in `coverage.md`, keep incomplete work in `tasks.md`, and
follow `RELEASING.md` for reviewed delivery. No live operation is required solely
to create this retrospective baseline.
