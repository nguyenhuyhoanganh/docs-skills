# Document Management Workflow

Use skill `using-doc-superpowers` and route document work through one orchestrator workflow.

Then:

1. Classify request mode:
   - `new-feature`: create documentation for a new feature scope.
   - `update-existing`: update existing documentation from codebase changes + existing docs + user request.
2. Run `doc-context-discovery` for both modes before any authoring/update.
3. If mode is `new-feature`, run core-4 pipeline in order:
   - `doc-feature-intake`
   - `doc-requirements-authoring`
   - `doc-hld-authoring`
   - `doc-dld-authoring`
4. If mode is `update-existing`:
   - run `doc-lifecycle-management` to decide update-in-place/version/deprecate,
   - then update only impacted sections using applicable phase skills (`doc-requirements-authoring`, `doc-hld-authoring`, `doc-dld-authoring`).
5. Add optional artifacts only when explicitly requested or scope requires:
   - `doc-api-spec-authoring`
   - `doc-ops-reliability-security`
   - `doc-traceability-and-gates`
   - `doc-diagrams-as-code` (when diagrams are needed)
6. Run required quality gates for selected scope.
7. If publish is requested, run `doc-confluence-publishing` after gates pass.