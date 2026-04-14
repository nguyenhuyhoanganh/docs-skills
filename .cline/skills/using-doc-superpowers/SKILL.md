---
name: using-doc-superpowers
description: Use when starting any conversation in this repository to enforce discovery-first workflow routing, Confluence governance, and publication gates before action.
---

<SUBAGENT-STOP>
If you were dispatched as a subagent for a narrow read-only task, skip this skill.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If there is even a 1% chance a document skill applies, you MUST invoke it before acting.

If a phase-specific skill applies, you do not have a choice. Use it.
</EXTREMELY-IMPORTANT>

## Instruction Priority

1. User explicit instructions
2. `CLINE.md`
3. `.clinerules/*`
4. Skills in `.cline/skills`
5. Default system behavior

## Mission

Produce enterprise documentation with explicit discovery evidence, gates, and traceability.

No ad-hoc writing.
No out-of-order architecture/design drafting.
No publish without gate evidence.

## Agent Execution Topology (Capability Contract)

Treat this section as machine-operational policy. It defines delegation boundaries and a forward-compatible upgrade path.

### Role Contract

| Role | Primary Responsibility | Allowed Operations | Disallowed Operations | Mandatory Deliverable |
|---|---|---|---|---|
| `main-agent` | Orchestrate full documentation lifecycle | discovery routing, authoring, validation, gates, Confluence publish/update, metadata/status transitions | none (subject to platform and user policy) | final approved artifact set + gate decision |
| `subagent-research` | Parallel evidence collection only | read files, list/search symbols, read-only command execution, skill-assisted analysis | file writes, patching, MCP calls, Confluence operations, browser/web search, spawning nested subagents | bounded research memo with file/path evidence |

### Subagent Capability Levels (Future Compatibility Layer)

Do not rewrite workflow logic when platform capabilities change. Use level-based gating:

- `R0` (default/current): read-only research only
- `R1` (reserved): read + local file edits (no MCP)
- `R2` (reserved): read + local file edits + MCP tool use
- `R3` (reserved): near-full parity with main-agent

Unless explicitly overridden by runtime/platform evidence, assume `SUBAGENT_CAPABILITY_LEVEL=R0`.

### Delegation Routing Algorithm

For every workflow step, classify task type:

1. `research` (discovery, indexing, evidence extraction)
2. `authoring` (requirements/HLD/DLD/API/Ops content generation and edits)
3. `governance` (traceability gates, status decisions, metadata integrity)
4. `publish` (Confluence upsert/move/archive/review tasks)

Assignment rules:

- If task type is `authoring`, `governance`, or `publish`: assign to `main-agent` by default.
- If task type is `research`: may assign to `subagent-research`.
- If future platform upgrades subagent capability, only relax assignment if capability level satisfies required operation set.
- Even at higher future levels, `GO-PUBLISH` decision remains a main-agent responsibility unless user explicitly authorizes otherwise.

### Reserved Upgrade Hooks (Do Not Delete)

Keep these reserved switches in policy text so future upgrades require configuration change, not document redesign:

- `SUBAGENT_CAPABILITY_LEVEL`
- `ALLOW_SUBAGENT_AUTHORING` (default `false`)
- `ALLOW_SUBAGENT_MCP` (default `false`)
- `ALLOW_SUBAGENT_PUBLISH` (default `false`)

## Discovery First (Non-Negotiable)

Before any create/update flow:

1. Run `doc-context-discovery`
2. Build keyword-based relevance map from codebase and Confluence
3. Reuse/update existing docs when possible
4. If relevance is low, ask user for pointers before authoring

## Workflow Router

```dot
digraph workflow_router {
    "Doc request received" [shape=doublecircle];
    "Context discovery done?" [shape=diamond];
    "New feature docs?" [shape=diamond];
    "Code change update?" [shape=diamond];
    "Legacy/backfill?" [shape=diamond];
    "Periodic refresh?" [shape=diamond];
    "Incident-driven update?" [shape=diamond];

    "Doc request received" -> "Context discovery done?";
    "Context discovery done?" -> "doc-context-discovery" [label="no"];
    "Context discovery done?" -> "New feature docs?" [label="yes"];

    "New feature docs?" -> "Full pipeline: intake -> requirements -> HLD -> DLD -> API -> ops/security -> traceability -> publish" [label="yes"];
    "New feature docs?" -> "Code change update?" [label="no"];
    "Code change update?" -> "Workflow: update-doc-from-code-change" [label="yes"];
    "Code change update?" -> "Legacy/backfill?" [label="no"];
    "Legacy/backfill?" -> "Workflow: backfill-doc-from-codebase" [label="yes"];
    "Legacy/backfill?" -> "Periodic refresh?" [label="no"];
    "Periodic refresh?" -> "Workflow: periodic-doc-refresh" [label="yes"];
    "Periodic refresh?" -> "Incident-driven update?" [label="no"];
    "Incident-driven update?" -> "Workflow: incident-driven-doc-update" [label="yes"];
    "Incident-driven update?" -> "Workflow: create-doc-from-existing-assets" [label="no"];
}
```

## Diagram Policy

- Use `doc-diagrams-as-code` when diagrams are needed.
- Default: PlantUML.
- Fallback: Mermaid only when rendering/runtime constraints require it.

## Red Flags (Stop Immediately)

- "I can draft HLD first and backfill requirements later"
- "This is small, skip discovery"
- "Create a new page quickly, no need to search"
- "Publish now, review later"
- "Security/ops can be added after release"

All are failures. Return to the correct phase skill.

## Confluence Tool Contract

Read before any Confluence operation:
- `references/confluence-tools.md`

## Required Skill Selection

- Discovery and relevance mapping: `doc-context-discovery`
- Intake and context: `doc-feature-intake`
- Requirements: `doc-requirements-authoring`
- HLD: `doc-hld-authoring`
- DLD: `doc-dld-authoring`
- API/Event contracts: `doc-api-spec-authoring`
- Ops/Reliability/Security: `doc-ops-reliability-security`
- Diagram authoring: `doc-diagrams-as-code`
- Gate verification: `doc-traceability-and-gates`
- Publish/update: `doc-confluence-publishing`
- Lifecycle maintenance: `doc-lifecycle-management`
