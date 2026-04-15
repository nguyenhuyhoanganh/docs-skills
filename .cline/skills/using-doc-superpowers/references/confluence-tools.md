# Confluence MCP Tool Reference

Namespace: `ConfluenceDocOps`

These tools are the expected contract used by this repository's document skills.

## Discovery and Read

- `ConfluenceDocOps.search_pages(space_key, query, labels, limit)`
- `ConfluenceDocOps.search_pages_by_keywords(space_key, keywords, limit)`
- `ConfluenceDocOps.search_pages_semantic(space_key, query, limit)`
- `ConfluenceDocOps.read_page(page_id)`
- `ConfluenceDocOps.list_children(parent_page_id)`
- `ConfluenceDocOps.list_page_attachments(page_id)`
- `ConfluenceDocOps.extract_page_keywords(page_id)`
- `ConfluenceDocOps.diff_page_versions(page_id, from_version, to_version)`

## Create and Update

- `ConfluenceDocOps.upsert_page(space_key, title, parent_page_id, body_markdown, labels, metadata)`
- `ConfluenceDocOps.move_page(page_id, new_parent_page_id)`
- `ConfluenceDocOps.attach_artifact(page_id, file_path, artifact_type)`
- `ConfluenceDocOps.set_page_metadata(page_id, owner, status, review_date, doc_type, version)`

## Governance Actions

- `ConfluenceDocOps.create_review_task(page_id, reviewers, due_date)`
- `ConfluenceDocOps.archive_page(page_id, reason, approval_token)`

## Required Metadata Schema

Every authored or updated page must include:

- `doc_type`: one of `feature-brief`, `requirements`, `hld`, `dld`, `api-spec`, `ops-runbook`, `security-model`, `traceability`, `release-readiness`, `adr-index`
- `owner`: team or individual owner
- `status`: one of `draft`, `in-review`, `approved`, `published`, `deprecated`, `archived`
- `version`: semantic or monotonic integer version
- `review_date`: ISO date for next review
- `traceability_ref`: link or key to RTM artifact (or inline reference key for core-4 scope without dedicated traceability page)

## Discovery Protocol (Mandatory)

1. Derive keyword set from request (domain nouns, service names, entities, APIs, incidents).
2. Run `search_pages_by_keywords` with the keyword set.
3. Run `search_pages_semantic` for broader similarity.
4. Read top candidates and score relevance (`high`, `medium`, `low`).
5. Reuse/update when relevance is `high` or `medium`.
6. If all candidates are `low`, ask user for additional pointers (space key, page links, owner teams).

## Hard Rules

- Always run discovery protocol before `upsert_page`.
- Always call `set_page_metadata` immediately after create/update.
- Never call `archive_page` without an explicit approval token.
- Never publish pages with missing required metadata.
