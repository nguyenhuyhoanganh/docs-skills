---
name: doc-hld-authoring
description: Use when requirements are approved and you need system-level architecture, boundaries, and decision rationale for the feature.
---

# HLD Authoring

## Overview

Produce high-level architecture that can survive cross-team review.

<HARD-GATE>
Do not author HLD against unapproved requirements.
</HARD-GATE>

## Template Reference (Required, Reference-Only)

- Consult `references/hld.template.md` before drafting or updating HLD.
- Use the template as structure guidance only; adapt sections to system scope.
- Do not keep unresolved placeholders in final content.

## Required Inputs

- Approved requirements page
- Current architecture baseline
- Dependency map

## Required Sections

- System context and actors
- Architecture scope and boundaries
- Component/container map
- Data flow (read/write paths)
- Integration points and external dependencies
- Failure domains and fallback posture
- Capacity/performance assumptions
- Security and compliance impacts
- ADR candidates and tradeoffs

## ADR Rule

Every meaningful architecture choice must either:

- Reference existing ADR, or
- Create a new ADR entry with options and rationale

## Output Quality Standard

- Architecture must map to requirement IDs
- Tradeoffs must include rejected options
- Risks must include mitigation direction

## Confluence Behavior

- Upsert page with `doc_type=hld`
- Link to requirements page and ADR index
