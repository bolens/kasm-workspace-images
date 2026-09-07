# Agent guidance

[Documentation](docs/README.md) maps architecture, deployment, state, and document ownership.

Read [.specify/memory/constitution.md](.specify/memory/constitution.md) and the target image definition.

- Never embed credentials in build args, layers, examples, or logs. Treat image
  privileges, devices, ports, and remote package sources as security-relevant.
- Building may be local validation; pushing images or changing Harbor/Kasm is
  an external operation requiring explicit authorization.
- Preserve unrelated edits in [README.md](README.md) and other dirty files.

## Planning and evidence

Use the [project guide](.specify/memory/project-guide.md) and
[constitution](.specify/memory/constitution.md) for substantial changes. The guide
owns Spec Kit scope, retained history, retrospective requirements, and acceptance
evidence. Prose maintenance uses the normal repository workflow.

## Context and handoffs

- Search before reading. Use bounded source excerpts for exploratory reads over
  350 lines, and inspect required guidance and actual source before editing.
- When delegation is permitted, assign a bounded question or output, paths, and
  check. Return source locations, changes, and verification gaps for final review.
- Keep durable corrections in the [project guide](.specify/memory/project-guide.md)
  or owning contract. Replace superseded advice and read it before reuse.
  Temporary progress belongs in task notes. Preserve existing authority rules.
