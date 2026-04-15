---
name: doc-traceability-and-gates
description: Use when validating documentation completeness for governance mode, proving requirement traceability across in-scope artifacts before publish.
---

# Traceability and Quality Gates

## Overview

Enforce evidence-based readiness before publication.

Use this skill when traceability/governance artifact is explicitly requested or required.

## Template Reference (Required, Reference-Only)

- Consult `references/traceability.template.md` before drafting a dedicated traceability artifact.
- Use the template as structure guidance only; adapt matrix columns by in-scope artifacts.
- Do not keep unresolved placeholders in final content.

## Required Traceability Matrix

For each `REQ-ID`, capture links to:

- Requirements section
- HLD section
- DLD section
- API/Event contract section (if in scope)
- Test strategy reference (if in scope)
- Ops/Security reference (if in scope)

## Gate Checklist

- [ ] No placeholder text
- [ ] No unresolved contradictions
- [ ] Every requirement has downstream artifacts required by current scope
- [ ] Every in-scope contract has owner and version
- [ ] Every document has metadata (`doc_type`, `owner`, `status`, `version`, `review_date`)
- [ ] Open risks are explicit and accepted

## Publish Decision

- If all checks pass: `GO-PUBLISH`
- If any check fails: `NO-PUBLISH` with explicit blocking list

<HARD-GATE>
Never proceed to publish when decision is `NO-PUBLISH`.
</HARD-GATE>

## Confluence Behavior

- If dedicated traceability artifact is requested, upsert page with `doc_type=traceability`
- Otherwise produce inline gate summary and status decision in the publish bundle
- Set status to `approved` only after all required gates pass
