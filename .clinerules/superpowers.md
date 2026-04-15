# Document Superpowers Rules

This project uses skills from `.cline/skills`.

Rules:

- Runtime boundary: treat `.cline/*` and `.clinerules/*` as runtime instruction surface; treat root/docs markdown as user-facing reference only.
- Before substantial work, load the relevant document skill.
- Use skill-driven workflow for non-trivial document work.
- For any create/update task, run `doc-context-discovery` first.
- Before authoring, consult the matching local `references/*.template.md` in the active skill as reference.
- For new feature docs, default authoring scope is core-4: `feature-brief -> requirements -> hld -> dld`.
- Add API/Ops/Security/Traceability/Release-readiness/ADR artifacts only when user asks or scope demands.
- Prefer update-in-place over creating duplicate documents.
- Never draft architecture/design before requirements are approved.
- Always search and read existing Confluence documents before creating new ones.
- Use PlantUML by default for architecture/process diagrams. Use Mermaid only as explicit fallback.
- For any Confluence write operation, include doc metadata: `doc_type`, `owner`, `status`, `version`, `review_date`.
- No publish when required quality gates for the selected scope fail.
- Run traceability gate only when traceability/governance artifact is in scope.
- Prefer process skills first, then phase-specific authoring skills.
- If discovery confidence is low, ask user for pointers (space/page links/keywords) before proceeding.
- For enterprise or release-governed changes, include reliability/security/readiness artifacts as needed.
- Support workflow families: new feature docs, update-from-change, backfill, periodic refresh, incident-driven updates, mixed-source synthesis, reverse-engineering.
- Keep document lifecycle explicit: draft -> review -> approved -> published -> maintained -> archived.
