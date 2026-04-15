# Reverse Engineer Feature Docs Workflow

Use skills `doc-context-discovery`, phase authoring skills, `doc-diagrams-as-code`, and optionally `doc-traceability-and-gates` when governance artifact is required.

Then:

1. Scope discovery units from current codebase (module/interface/dependency boundaries).
2. Generate docs per unit (core-4 baseline: feature brief/requirements/HLD/DLD).
3. Add optional API/Ops/Security/Traceability sections only when requested or evidence requires.
4. Verify doc-to-code consistency for each unit independently.
5. Run review and conditional revise loop (max 2 cycles per unit).
6. If consistency remains low or review rejects after max cycles, flag mandatory human review.
7. Consolidate approved units into final artifact set (core + optional in-scope docs) and continue to publish workflow.
