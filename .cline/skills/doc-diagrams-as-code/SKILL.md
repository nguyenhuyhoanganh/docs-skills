---
name: doc-diagrams-as-code
description: Use when architecture or process documentation needs diagrams-as-code, with PlantUML as default and Mermaid only as fallback.
---

# Diagrams as Code

## Overview

Diagram generation is mandatory for architecture/process clarity.

Default language: PlantUML.
Fallback language: Mermaid.

<HARD-GATE>
Do not choose Mermaid unless there is a concrete rendering/runtime constraint.
</HARD-GATE>

## Preferred Diagram Set

- System context
- Container/component architecture
- Sequence and interaction flows
- Deployment topology
- Data flow and integration boundaries

## PlantUML First Policy

1. Author diagrams in PlantUML
2. Reuse C4-PlantUML macros for architecture views
3. Keep diagram source in doc body or attached artifact
4. Render to SVG/PNG only as output artifact; source remains canonical

## Mermaid Fallback Conditions

Use Mermaid only if:

- target platform blocks PlantUML rendering, or
- security/policy forbids PlantUML server/jar flow

When using Mermaid fallback, document reason in the page.

## Output Quality Rules

- Every diagram has title and scope
- Every relation has direction and label
- Every element maps to named system/component from HLD/DLD
- No unlabeled arrows in architecture diagrams

## References

- `references/diagram-standards.md`
- `references/plantuml-templates.md`
- `references/mermaid-fallback-templates.md`
