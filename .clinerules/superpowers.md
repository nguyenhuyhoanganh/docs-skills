# Document Superpowers Rules

This project uses skills from `.cline/skills`.

Rules:

- Before substantial work, load the relevant document skill.
- For any create/update task, run `doc-context-discovery` first.
- Never draft architecture/design before requirements are approved.
- Always search and read existing Confluence documents before creating new ones.
- Use PlantUML by default for architecture/process diagrams. Use Mermaid only as explicit fallback.
- For any Confluence write operation, include doc metadata: `doc_type`, `owner`, `status`, `version`, `review_date`.
- No publish when traceability gates fail.
- Prefer process skills first, then phase-specific authoring skills.
- If discovery confidence is low, ask user for pointers (space/page links/keywords) before proceeding.
- For enterprise changes, include reliability, security, and operational readiness artifacts.
- Keep document lifecycle explicit: draft -> review -> approved -> published -> maintained -> archived.
