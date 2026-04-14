---
name: doc-requirements-authoring
description: Use when converting a feature brief into auditable functional and non-functional requirements with acceptance criteria and measurable outcomes.
---

# Requirements Authoring

## Overview

Convert intake into testable requirements.

<HARD-GATE>
No HLD or DLD writing until requirements are complete and approved.
</HARD-GATE>

## Required Requirement Model

For each requirement, include:

- `REQ-ID`
- Statement (single responsibility)
- Rationale
- Priority (`must`, `should`, `could`)
- Acceptance criteria (Given/When/Then)
- Verification method (test type or metric)
- Owner

## Required Sections

- Functional requirements (FR)
- Non-functional requirements (NFR): reliability, performance, security, observability, compliance
- Constraints
- Out-of-scope
- Success metrics and KPIs
- Dependency assumptions
- Risk notes

## Anti-Patterns

- "Handle errors appropriately"
- "System should be scalable"
- "Low latency"

These are invalid unless quantified and testable.

## Quality Gate

Requirements are only "approved" when:

- Every FR has acceptance criteria
- Every NFR has measurable threshold
- No conflicting statements
- No placeholder text (`TBD`, `TODO`)

## Confluence Behavior

- Use or create page with `doc_type=requirements`
- Update status:
  - `draft` during authoring
  - `in-review` for review cycle
  - `approved` only when quality gate passes
