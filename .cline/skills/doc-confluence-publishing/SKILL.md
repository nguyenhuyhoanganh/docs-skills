---
name: doc-confluence-publishing
description: Use when publishing or updating approved documentation in Confluence with strict metadata, hierarchy, and review-task governance.
---

# Confluence Publishing and Governance

## Overview

Publish documentation in a controlled, auditable way.

<HARD-GATE>
No publish without completed traceability gate.
</HARD-GATE>

## MCP Preflight (Mandatory Before Any Publish Attempt)

Run a capability preflight for `ConfluenceDocOps` before publish sequence.

### Required Tool Surface

Minimum required tools for remote publish mode:

- `search_pages` or equivalent discovery/search
- `upsert_page`
- `set_page_metadata`
- `create_review_task`

Optional but expected for full lifecycle:

- `move_page`
- `archive_page`
- `attach_artifact`
- `diff_page_versions`

### Preflight Decision

- If required tools are available: set `PUBLISH_MODE=REMOTE_CONFLUENCE`
- If any required tool is missing/unreachable: set `PUBLISH_MODE=LOCAL_FALLBACK`

Do not silently downgrade. Decision must be explicit in output artifact.

## Publish Sequence

1. Run MCP preflight and set `PUBLISH_MODE`
2. If `PUBLISH_MODE=REMOTE_CONFLUENCE`:
   - Search existing pages to prevent duplicates
   - Upsert in correct parent hierarchy
   - Apply labels and metadata
   - Create review tasks
   - Record version and change summary
3. If `PUBLISH_MODE=LOCAL_FALLBACK`:
   - Do not call remote Confluence write operations
   - Build deterministic publish bundle for later replay
   - Emit blocked status with exact missing capability list

## Metadata Minimum

Every page must include:

- `doc_type`
- `owner`
- `status`
- `version`
- `review_date`
- `traceability_ref`

## Required Status Transition

`draft` -> `in-review` -> `approved` -> `published`

No direct transition from `draft` to `published`.

## Review Task Rule

Every `published` page must have reviewer assignment and due date.

## Archive Rule

Archive only when:

- Replacement reference exists, and
- Approval token exists

## Tooling Rule

Use `ConfluenceDocOps.*` tools per contract in `using-doc-superpowers/references/confluence-tools.md`.

## Local Fallback Bundle Contract

When `PUBLISH_MODE=LOCAL_FALLBACK`, create:

- `docs/publish-bundle/<timestamp>/manifest.json`
- `docs/publish-bundle/<timestamp>/review-tasks.json`
- `docs/publish-bundle/<timestamp>/change-summary.md`

`manifest.json` must include for each page candidate:

- target title
- intended parent reference
- full metadata block (`doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`)
- source artifact reference path
- planned status transition
- replay order index

`review-tasks.json` must include:

- page key/title reference
- reviewers
- due date
- dependency (`after_upsert=true`)

## Fallback Exit Criteria

Fallback is complete only when:

- missing MCP capability list is explicit
- replay bundle exists and is internally consistent
- overall publish result is marked `BLOCKED_MCP_UNAVAILABLE` (not `published`)
