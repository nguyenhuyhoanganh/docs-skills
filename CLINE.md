# CLINE.md

This project is configured for document-driven delivery with Confluence MCP integration.

Priority:

1. User request
2. This file
3. `.clinerules/*`
4. Skills in `.cline/skills`

Working policy:

- Use skill-driven workflow for non-trivial document work.
- Start every create/update workflow with `doc-context-discovery`.
- Prefer update-in-place over creating duplicate documents.
- Use diagrams-as-code for architecture/process docs, with PlantUML as default and Mermaid as fallback only.
- No publish to Confluence without traceability and quality gates passing.
- Support multiple common workflow families: new feature docs, update-from-change, backfill from codebase, periodic refresh, and incident-driven updates.
