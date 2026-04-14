---
name: doc-traceability-and-gates
description: Use when validating documentation completeness by proving requirement-to-design-to-contract-to-operations traceability before publish.
---

# Traceability and Quality Gates

## Overview

Enforce evidence-based readiness before publication.

## Required Traceability Matrix

For each `REQ-ID`, capture links to:

- Requirements section
- HLD section
- DLD section
- API/Event contract section
- Test strategy reference
- Ops/Security reference

## Gate Checklist

- [ ] No placeholder text
- [ ] No unresolved contradictions
- [ ] Every requirement has downstream artifacts
- [ ] Every contract has owner and version
- [ ] Every document has metadata (`doc_type`, `owner`, `status`, `version`, `review_date`)
- [ ] Open risks are explicit and accepted

## Publish Decision

- If all checks pass: `GO-PUBLISH`
- If any check fails: `NO-PUBLISH` with explicit blocking list

<HARD-GATE>
Never proceed to publish when decision is `NO-PUBLISH`.
</HARD-GATE>

## Confluence Behavior

- Upsert page with `doc_type=traceability`
- Set status to `approved` only after all gates pass
