# Document Management Superpowers Setup

This repository provides a strict, enterprise-grade workflow surface for managing product and engineering documentation with Confluence MCP tools.

## Core Outcome

Transform incoming feature requests into governed, production-ready documentation sets with traceability from requirement to architecture, design, API contracts, operations, and publication.

## Entry Rule (Hard Gate)

For any create/update request, run context discovery first:

- codebase discovery (symbols, modules, existing contracts)
- Confluence discovery (keyword and semantic search)
- relevance ranking and reuse plan

Only after discovery can authoring workflows continue.

## Workflow Catalog (Most Common)

1. New feature documentation (full pipeline)
2. Update docs from code change (delta update)
3. Backfill docs from existing codebase (legacy systems)
4. Create doc from existing assets (mixed source synthesis)
5. Periodic refresh of stale docs (review-date driven)
6. Incident-driven documentation updates (runbooks, postmortem links)
7. Reverse-engineer feature docs from implemented code (unit-based verify/review loops)

Router workflow:
- `.clinerules/workflows/workflow-router.md`

## Feature Documentation Pipeline (for New Features)

1. Context discovery
2. Feature intake and context normalization
3. Functional + non-functional requirements
4. HLD (system boundaries, components, tradeoffs)
5. DLD (module behavior, state/sequence, failure handling)
6. API/Event contracts (OpenAPI/AsyncAPI and compatibility policy)
7. Ops, reliability, security, and compliance artifacts
8. Traceability and quality gates
9. Confluence publish/update with metadata and review tasks

## Diagram Strategy (PlantUML First)

- Default diagram language: PlantUML
- Standard architecture notation: C4-PlantUML where applicable
- Mermaid allowed only as fallback when rendering constraints require it

Skill:
- `.cline/skills/doc-diagrams-as-code/SKILL.md`

## Enterprise Artifact Scope (beyond basic examples)

- PRD / Feature brief
- Requirements spec (FR, NFR, acceptance criteria, constraints)
- HLD and ADR set
- DLD by subsystem
- API/Event specs and change policy
- Data model + migration notes
- Test strategy and release readiness criteria
- SLI/SLO and error budget policy
- Runbooks and incident escalation notes
- Threat model and security controls
- Compliance notes and audit trail references
- Traceability matrix and document lifecycle metadata

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
- `.clinerules/superpowers.md`: Rule layer enforcing sequence and gates
- `.clinerules/workflows/`: Workflow wrappers for documentation families
- `CLINE.md`: Project-level instruction priority

## Confluence MCP Assumption

This setup assumes a Confluence MCP server is connected with tools for search/read/create/update/move/archive/version diff/metadata/review tasks.

Reference tool contract is defined in:
- `.cline/skills/using-doc-superpowers/references/confluence-tools.md`



