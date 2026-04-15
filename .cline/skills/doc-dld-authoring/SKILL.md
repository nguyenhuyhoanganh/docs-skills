---
name: doc-dld-authoring
description: Use when HLD is complete and you need module-level design, execution flow, state behavior, and failure handling details.
---

# DLD Authoring

## Overview

Define implementation-grade detail without drifting from HLD/requirements.

<HARD-GATE>
Do not invent scope not present in requirements/HLD.
</HARD-GATE>

## Template Reference (Required, Reference-Only)

- Consult `references/dld.template.md` before drafting or updating DLD.
- Use the template as structure guidance only; adapt for module-specific behavior.
- Do not keep unresolved placeholders in final content.

## Required Sections

- Module decomposition
- Internal interfaces and contracts
- Sequence and state transitions
- Data structures and persistence behavior
- Validation and error handling strategy
- Retry, timeout, idempotency behavior
- Concurrency and race-condition notes
- Migration/rollback considerations

## Mapping Rule

Every major DLD section must reference:

- At least one `REQ-ID`
- At least one HLD section

## Quality Bar

- No vague statements without concrete behavior
- No hidden side effects
- No unresolved failure mode left undocumented

## Confluence Behavior

- Upsert page with `doc_type=dld`
- Add labels for subsystem ownership
