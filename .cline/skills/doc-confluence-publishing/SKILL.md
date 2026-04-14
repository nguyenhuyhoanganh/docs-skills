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

## Publish Sequence

1. Search existing pages to prevent duplicates
2. Upsert in correct parent hierarchy
3. Apply labels and metadata
4. Create review tasks
5. Record version and change summary

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
