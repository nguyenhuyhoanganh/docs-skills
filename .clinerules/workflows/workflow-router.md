# Workflow Router

Use skill `using-doc-superpowers` and route to the correct workflow family.

Then:

1. Run `discover-context` first.
2. Pick workflow by request type:
   - new feature -> `intake-feature` + full feature pipeline
   - code change update -> `update-doc-from-code-change`
   - legacy docs backfill -> `backfill-doc-from-codebase`
   - stale docs review cycle -> `periodic-doc-refresh`
   - incident follow-up -> `incident-driven-doc-update`
   - mixed source synthesis -> `create-doc-from-existing-assets`
3. Continue with traceability gate and publish workflow if needed.
