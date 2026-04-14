# Reverse Engineer Feature Docs Workflow

Use skills `doc-context-discovery`, phase authoring skills, `doc-diagrams-as-code`, and `doc-traceability-and-gates`.

Then:

1. Scope discovery units from current codebase (module/interface/dependency boundaries).
2. Generate docs per unit (requirements baseline, HLD/DLD/API sections as needed).
3. Verify doc-to-code consistency for each unit independently.
4. Run review and conditional revise loop (max 2 cycles per unit).
5. If consistency remains low or review rejects after max cycles, flag mandatory human review.
6. Consolidate approved units into final traceability artifact and continue to publish workflow.
