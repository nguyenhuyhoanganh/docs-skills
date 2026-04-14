# Publish Confluence Workflow

Use skill `doc-confluence-publishing`.

Then:

1. Run MCP preflight for `ConfluenceDocOps` and set `PUBLISH_MODE`.
2. If `PUBLISH_MODE=REMOTE_CONFLUENCE`, upsert pages with metadata/governance tags and apply required status transitions.
3. If `PUBLISH_MODE=REMOTE_CONFLUENCE`, create review tasks and record version/change summary in parent index page.
4. If `PUBLISH_MODE=LOCAL_FALLBACK`, generate local publish bundle and return explicit blocked state `BLOCKED_MCP_UNAVAILABLE`.
