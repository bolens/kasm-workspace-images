# Agent guidance

Before Spec Kit planning or implementation, read
`.specify/memory/project-guide.md` with the project constitution. It maps
requirements to this repository's source, acceptance evidence, and validation.

Read `.specify/memory/constitution.md` and the target image definition.

- Never embed credentials in build args, layers, examples, or logs. Treat image
  privileges, devices, ports, and remote package sources as security-relevant.
- Building may be local validation; pushing images or changing Harbor/Kasm is
  an external operation requiring explicit authorization.
- Preserve unrelated edits in `README.md` and other dirty files.

## Spec-driven changes

Use Spec Kit for new capabilities, architecture, security-sensitive behavior,
migrations, and coordinated multi-file changes. Keep narrow fixes, dependency
updates, prose edits, and release housekeeping in the normal repository
workflow unless their risk warrants a written specification. Keep completed
feature directories under `specs/` as decision history; do not backfill them for
finished work.
