# Document Management Superpowers Setup

This repository provides a strict, enterprise-grade workflow surface for managing product and engineering documentation with Confluence MCP tools.

## Boundary Model

- User-facing reference surface: root markdown files and `docs/*`.
- Cline runtime surface: `.cline/*` and `.clinerules/*`.
- Runtime behavior is controlled by internal surfaces only unless a runtime rule explicitly imports external reference content.

## Core Outcome

Transform incoming feature requests into governed documentation sets with a core 4-document baseline:

- feature brief
- requirements
- HLD
- DLD

Additional artifacts are created only when explicitly requested or when scope requires them.

## Entry Rule (Hard Gate)

For any create/update request, run context discovery first:

- codebase discovery (symbols, modules, existing contracts)
- Confluence discovery (keyword and semantic search)
- relevance ranking and reuse plan

Only after discovery can authoring workflows continue.

## Workflow Catalog (Most Common)

1. New feature documentation (core-4 default, optional extensions on demand)
2. Update docs from code change (delta update)
3. Backfill docs from existing codebase (legacy systems)
4. Create doc from existing assets (mixed source synthesis)
5. Periodic refresh of stale docs (review-date driven)
6. Incident-driven documentation updates (runbooks, postmortem links)
7. Reverse-engineer feature docs from implemented code (unit-based verify/review loops)

Router workflow:
- `.clinerules/workflows/workflow-router.md`

## Feature Documentation Pipeline (for New Features, Default Mode)

1. Context discovery
2. Feature intake and context normalization
3. Functional + non-functional requirements
4. HLD (system boundaries, components, tradeoffs)
5. DLD (module behavior, state/sequence, failure handling)
6. Optional extension docs when requested:
   - API/Event contracts
   - Ops/runbook/security artifacts
   - Traceability/release-readiness/ADR artifacts
7. Run required quality gates for the selected scope
8. Confluence publish/update with metadata and review tasks (if requested)

## Diagram Strategy (PlantUML First)

- Default diagram language: PlantUML
- Standard architecture notation: C4-PlantUML where applicable
- Mermaid allowed only as fallback when rendering constraints require it

Skill:
- `.cline/skills/doc-diagrams-as-code/SKILL.md`

## Artifact Scope

Default artifacts (always in new-feature default mode):

- Feature brief
- Requirements spec
- HLD
- DLD

Optional artifacts (on-demand):

- API/Event specs and change policy
- Ops runbook and incident escalation notes
- Security model and control mapping
- Traceability matrix and release-readiness checklist
- ADR set
- Data model + migration notes
- Test strategy and release readiness criteria
- SLI/SLO and error budget policy
- Threat model and security controls
- Compliance notes and audit trail references
- Document lifecycle metadata

## External Benchmark Sources

- `docs/benchmark-skill-sources.md`

## Documentation Governance Pack (Software Development)

To run this repository as a full software-documentation operating model, use:

- `docs/index.md` (central docs entrypoint)
- `docs/sidebar.json` (single-source navigation taxonomy)
- `DOCS_CONTRIBUTING.md` (docs contribution process)
- `DOCS_STYLEGUIDE.md` (writing standards)
- `QUALITY_GATES.md` (phase quality gates)
- `TEMPLATE_INDEX.md` (doc-type to template mapping)
- `docs/templates/*` (artifact templates)
- `docs/changelog/latest.md` (latest documentation changes)

## What Is Installed

- `.cline/skills/`: Project-local document management skills
- `.clinerules/hooks/TaskStart.ps1`: Windows bootstrap hook
- `.clinerules/hooks/TaskStart`: macOS/Linux bootstrap hook
- `.clinerules/superpowers.md`: Single rule source enforcing sequence and gates
- `.clinerules/workflows/`: Workflow wrappers for documentation families

## Confluence MCP Assumption

This setup assumes a Confluence MCP server is connected with tools for search/read/create/update/move/archive/version diff/metadata/review tasks.

Reference tool contract is defined in:
- `.cline/skills/using-doc-superpowers/references/confluence-tools.md`



