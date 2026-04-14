---
name: doc-feature-intake
description: Use when a new feature request arrives and you must normalize scope, context, risks, and unknowns before writing requirements.
---

# Feature Intake

## Overview

Transform raw feature asks into a normalized feature brief with explicit context and boundary.

<HARD-GATE>
Do not start requirements authoring until intake is complete.
Do not start intake authoring until context discovery report exists.
</HARD-GATE>

## Checklist

1. Load context discovery report
2. Collect request statement and business objective
3. Validate affected codebase touchpoints from discovery
4. Validate Confluence overlap/reuse candidates from discovery
5. Identify dependencies, constraints, unknowns
6. Produce feature brief with acceptance boundary

## Mandatory Actions

- Reuse discovery evidence; do not re-invent context
- Prefer update over creating duplicate pages
- Record unresolved unknowns explicitly

## Output: Feature Brief (Required Sections)

- Problem statement
- Business objective and measurable outcome
- In-scope and out-of-scope
- Affected systems/components
- Existing behavior summary
- Assumptions and constraints
- Risks and open questions
- Candidate requirement themes

## Confluence Behavior

- Prefer update to an existing feature brief page when one exists
- If creating new page, set `doc_type=feature-brief` and `status=draft`

## Exit Criteria

- Feature brief exists with all required sections
- Unknowns are explicit (not hidden)
- Boundary is clear enough to begin requirements
