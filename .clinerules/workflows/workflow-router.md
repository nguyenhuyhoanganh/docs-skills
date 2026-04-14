# Workflow Router

Use skill `using-doc-superpowers` and route to the correct workflow family.

Then:

1. Run `discover-context` first.
2. Pick workflow by request type:
   - new feature -> `intake-feature` + full feature pipeline
   - code change update -> `update-doc-from-code-change`
   - legacy docs backfill -> `backfill-doc-from-codebase`
   - reverse-engineer feature from existing implementation -> `reverse-engineer-feature-docs`
   - stale docs review cycle -> `periodic-doc-refresh`
   - incident follow-up -> `incident-driven-doc-update`
   - mixed source synthesis -> `create-doc-from-existing-assets`
3. Apply execution topology from `using-doc-superpowers` capability contract:
   - `research` steps may be delegated to `subagent-research` when available.
   - `authoring`, `governance`, and `publish` steps remain on `main-agent` at capability level `R0`.
4. Continue with traceability gate and publish workflow if needed.

## Future Capability Reserved Logic

Do not fork workflow files for future Cline updates. Use capability level gating:

- If `SUBAGENT_CAPABILITY_LEVEL=R0`: delegate only read-only discovery research.
- If `SUBAGENT_CAPABILITY_LEVEL>=R1`: optional delegation of bounded authoring drafts only when explicitly enabled.
- If `SUBAGENT_CAPABILITY_LEVEL>=R2`: optional MCP-assisted delegation only when explicitly enabled.
- Publish decision authority remains with `main-agent` unless explicit policy override is approved.
