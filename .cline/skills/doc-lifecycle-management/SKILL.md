---
name: doc-lifecycle-management
description: Use when maintaining existing documentation over time, including stale detection, controlled updates, and deprecation or archival decisions.
---

# Document Lifecycle Management

## Overview

Keep documentation trustworthy after initial publish.

<HARD-GATE>
Before any update/archive decision, run context discovery and relevance check.
</HARD-GATE>

## Lifecycle States

- `draft`
- `in-review`
- `approved`
- `published`
- `deprecated`
- `archived`

## Maintenance Loop

```dot
digraph lifecycle_loop {
    "Published document" [shape=ellipse];
    "Discovery + relevance check done?" [shape=diamond];
    "Review due or change detected?" [shape=diamond];
    "Update required?" [shape=diamond];
    "Update in place" [shape=box];
    "Deprecate/Archive" [shape=box];
    "Republish" [shape=doublecircle];

    "Published document" -> "Discovery + relevance check done?";
    "Discovery + relevance check done?" -> "Run doc-context-discovery" [label="no"];
    "Discovery + relevance check done?" -> "Review due or change detected?" [label="yes"];
    "Review due or change detected?" -> "Update required?" [label="yes"];
    "Review due or change detected?" -> "Published document" [label="no"];
    "Update required?" -> "Update in place" [label="yes"];
    "Update required?" -> "Deprecate/Archive" [label="no, obsolete"];
    "Update in place" -> "Republish";
    "Deprecate/Archive" -> "Republish";
}
```

## Required Checks

- Detect pages with expired `review_date`
- Detect pages impacted by requirement/architecture/API changes
- Detect duplicate or conflicting pages
- Detect low-confidence ownership/status metadata

## Template Reference (Reference-Only for Major Rewrites)

- When a lifecycle update is effectively a major rewrite, consult the matching local `references/*.template.md` for that `doc_type`.
- Use templates as structure guidance only; do not force unnecessary sections for minor updates.

## Change Policy

- Minor change: metadata + content update in place
- Major change: new version with migration notes
- Obsolete docs: deprecate first, archive after grace window

## Archive Safety

Never archive without:

- successor page reference
- approval token
- consumer communication note
