# Requirement coverage

| Requirement | Source and acceptance evidence |
| --- | --- |
| FR-001 | All three Dockerfiles and `root/defaults/startwm.sh` files; Hadolint, ShellCheck, and Docker build checks. |
| FR-002 | README Build section and Dockerfile ARG/FROM declarations. Corrective acceptance: remove the ineffective KASM_VERSION argument and its misleading instruction. |
| FR-003 | Dockerfile COPY/chmod/USER declarations and startup shell syntax checks. |
| FR-004 | README Images/Notes and bazzite/Dockerfile introductory contract. |

## Verification receipt

On 2026-09-05: Hadolint passed at the repository error threshold, startup ShellCheck passed, and actionlint/zizmor passed. All three `docker buildx build --check` contexts passed using owner-authorized pkexec and absolute context paths. A separate self-review confirmed KASM_VERSION was unused in every FROM/build step, so removing the argument preserves image behavior and the revised instructions describe actual inputs. No image was built, pushed, or deployed. Hosted checks and merge evidence are recorded in the delivery PR.
