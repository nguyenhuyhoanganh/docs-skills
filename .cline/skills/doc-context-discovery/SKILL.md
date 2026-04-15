---
name: doc-context-discovery
description: Use when starting any document creation or update to discover and rank relevant context from codebase and Confluence before authoring.
---

# Context Discovery

## Overview

Build evidence before writing.

<HARD-GATE>
No create/update authoring before discovery report exists.
</HARD-GATE>

## Inputs

- User request or change summary
- Existing codebase
- Confluence space(s)

## Procedure

1. Extract keywords from request
2. Search codebase by keyword and symbols
3. Search Confluence by keyword and semantic match
4. Read top candidate documents
5. Score relevance and decide reuse vs create

## Codebase Discovery (Required)

- Use fast search (`rg`) for keyword and symbol hits
- Identify touched modules, APIs, models, migrations, runbooks
- Record path evidence with short rationale

## Confluence Discovery (Required)

- Run keyword search and semantic search
- Read candidate pages and gather ownership/status/version
- Record overlap, conflict, and stale signals

## Relevance Scoring

- `high`: directly same feature/domain and still valid
- `medium`: partially related; reuse sections with edits
- `low`: weak relation or obsolete structure

## Output: Context Discovery Report

- Keyword set used
- Codebase evidence list
- Confluence evidence list
- Relevance scoring table
- Reuse/update/new-page decision
- Missing context list
- Recommended `doc_type` and matching local `references/*.template.md` reference for next authoring phase

## Low-Confidence Rule

If all candidates are low confidence, ask user for one of:

- Confluence space key
- existing page links
- owning team/system names

Then rerun discovery.
