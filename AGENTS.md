# Agent guidance

Read `.specify/memory/constitution.md` and the target image definition.

- Never embed credentials in build args, layers, examples, or logs. Treat image
  privileges, devices, ports, and remote package sources as security-relevant.
- Building may be local validation; pushing images or changing Harbor/Kasm is
  an external operation requiring explicit authorization.
- Preserve unrelated edits in `README.md` and other dirty files.
