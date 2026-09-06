# Third-party notices

## License scope

The root MIT license covers original material authored by bolens. It does not
replace third-party licenses, copyright notices, trademarks, or service terms.
Imported and modified third-party material keeps its applicable upstream terms.

## Container images

The MIT grant covers the original Dockerfiles and maintenance documentation.
Built images also contain LinuxServer KasmVNC bases, distribution packages, and
other upstream components under their own licenses. See each Dockerfile's `FROM`
and package installation commands for the selected inputs. Retain package
license files in images. A source license is not a license for the whole image.

Before distributing an image, inventory the actual image digest and installed
package versions, retain required notices, and supply corresponding source where
required. The repository audit did not verify an image's complete software bill
of materials or corresponding-source delivery.

## GitHub Spec Kit

Imported `.specify/scripts/`, `.specify/templates/`, and
`.agents/skills/speckit-*` integration files retain GitHub's MIT copyright and
permission notice in [.specify/LICENSE](.specify/LICENSE). Include it when
copying these files. Project-authored memory documents have separate ownership.

## Redistribution

Keep applicable full license and copyright notices with copied source and
bundled dependencies, including minified JavaScript and compiled executables.
Use the exact dependency versions selected by the lockfile or build. Preserve
Apache NOTICE material and satisfy copyleft source requirements where they
apply. Development-only tools and separately installed programs keep their own
terms but are not automatically part of a distributed application.

This source inventory is not proof that every historical release, external
asset, fetched dataset, or built container has satisfied its license obligations.
