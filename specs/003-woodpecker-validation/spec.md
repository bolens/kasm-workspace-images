# Portable Woodpecker validation

Validate all three maintained Dockerfiles with the same pinned Hadolint image as GitHub, then lint startup scripts with ShellCheck.

Run on PR heads, main pushes and manual validation in immutable, ordinary Docker
containers. Supply no publishing credentials, host mounts or Docker socket.
Preserve existing platform, actual Docker, security and publication checks until
an equivalent native gate is observed. Exact native PR and genuine main success
are required before retiring duplicate hosted checks. No product release or
operational installation is part of this migration.
