# Superpowers Alignment Plan for `doc-management`

> Date: 2026-04-15  
> Scope: Align `doc-management` skill/workflow behavior with the operating style used in `obra/superpowers` while preserving document-domain governance.

**Goal:** Make skill transitions explicit, make reference loading deterministic, and make template binding enforceable at runtime (not only by convention).

---

## 1) Difference Matrix (Current vs Target)

| Area | `superpowers` behavior | `doc-management` current behavior | Gap |
|---|---|---|---|
| Transition model | Explicit skill-to-skill terminal transitions and required next skill. | Router + phase skills exist, but several transitions are implicit across multiple files. | Medium |
| Entry bootstrap | Session start and native skill discovery are formalized. | TaskStart injects `using-doc-superpowers` well, but downstream phase transitions are less explicit. | Low |
| Reference loading | Skill text often states when to load supporting references/prompt templates. | Confluence reference is explicit; other references/templates are partly convention-based. | Medium |
| Template enforcement | Workflow relies on structured plans and required sub-skills; execution is tightly specified. | Template usage is documented but not hard-bound in each `write-*` workflow/skill step. | High |
| Validation harness | Includes skill-trigger and premature-action tests. | No equivalent automated harness to prove transition discipline. | High |
| Execution contract | Subagent and review loops are explicit and testable. | Capability contract exists but fewer executable checks/assertions. | Medium |

---

## 2) Target Architecture (After Alignment)

1. **Entry layer:** keep TaskStart bootstrap of `using-doc-superpowers`.
2. **Router layer:** route only; no hidden phase decisions.
3. **Phase layer:** every phase workflow contains `Entry condition`, `Exit condition`, `Next workflow`.
4. **Reference layer:** every skill declares `Required references` + `When to load`.
5. **Template layer:** deterministic `doc_type -> template` resolution at authoring time.
6. **Verification layer:** test scripts assert skill invocation order and no premature authoring/publish actions.

---

## 3) Code Change Plan (Detailed)

### Task 1: Make phase transitions explicit in workflows

**Files to modify**
- `.clinerules/workflows/workflow-router.md`
- `.clinerules/workflows/intake-feature.md`
- `.clinerules/workflows/write-requirements.md`
- `.clinerules/workflows/write-hld.md`
- `.clinerules/workflows/write-dld.md`
- `.clinerules/workflows/write-api-spec.md`
- `.clinerules/workflows/write-ops-and-security.md`
- `.clinerules/workflows/traceability-check.md`
- `.clinerules/workflows/publish-confluence.md`

**Changes**
1. Add a strict section block in each workflow:
   - `Entry condition`
   - `Required input artifact(s)`
   - `Exit condition`
   - `Next workflow`
2. In `workflow-router.md`, replace implicit "full pipeline" wording with explicit next-hop sequence references.
3. Ensure each phase declares which output artifact is required by the next phase.

**Acceptance**
- No phase transition depends on inference from another file.
- For new feature path, chain is readable linearly from workflow files only.

---

### Task 2: Add a transition contract to `using-doc-superpowers`

**Files to modify**
- `.cline/skills/using-doc-superpowers/SKILL.md`

**Changes**
1. Add `Transition Contract` section with a compact state table:
   - state
   - required artifact
   - allowed next state(s)
   - blocked conditions
2. Add hard rule: "No phase skip unless user explicitly overrides".
3. Add one concrete example sequence for `new feature`.

**Acceptance**
- Skill text alone defines legal transitions without opening workflow markdowns.

---

### Task 3: Standardize reference-loading behavior

**Files to create**
- `.cline/skills/using-doc-superpowers/references/reference-loading-policy.md`

**Files to modify**
- `.cline/skills/using-doc-superpowers/SKILL.md`
- `.cline/skills/doc-feature-intake/SKILL.md`
- `.cline/skills/doc-requirements-authoring/SKILL.md`
- `.cline/skills/doc-hld-authoring/SKILL.md`
- `.cline/skills/doc-dld-authoring/SKILL.md`
- `.cline/skills/doc-api-spec-authoring/SKILL.md`
- `.cline/skills/doc-ops-reliability-security/SKILL.md`
- `.cline/skills/doc-traceability-and-gates/SKILL.md`
- `.cline/skills/doc-confluence-publishing/SKILL.md`

**Changes**
1. In each skill add:
   - `Required references`
   - `Reference load trigger`
   - `Reference evidence in output` (what must be shown)
2. Keep Confluence contract as mandatory for publish/update flows.
3. Enforce "load only needed references" to avoid context bloat.

**Acceptance**
- Every phase skill states exactly what it must load before acting.

---

### Task 4: Enforce template resolution at runtime

**Files to create**
- `.cline/skills/doc-template-resolution/SKILL.md`
- `.cline/skills/doc-template-resolution/references/doc-type-template-map.md`

**Files to modify**
- `.clinerules/workflows/write-requirements.md`
- `.clinerules/workflows/write-hld.md`
- `.clinerules/workflows/write-dld.md`
- `.clinerules/workflows/write-api-spec.md`
- `.clinerules/workflows/write-ops-and-security.md`
- `.clinerules/workflows/traceability-check.md`
- `TEMPLATE_INDEX.md`
- `DOCS_CONTRIBUTING.md`

**Changes**
1. New `doc-template-resolution` skill:
   - resolve `doc_type` to template path
   - verify template exists
   - output selected template and required sections
2. Add mandatory pre-authoring step in each `write-*` workflow:
   - invoke `doc-template-resolution`
   - include resolved template path in output artifact.
3. Keep `TEMPLATE_INDEX.md` as source of truth, with machine-readable mapping block.

**Acceptance**
- Authoring phase cannot start without an explicit template selection record.

---

### Task 5: Add a skill/workflow verification harness

**Files to create**
- `tests/skill-triggering/run-test.sh`
- `tests/skill-triggering/run-all.sh`
- `tests/skill-triggering/prompts/new-feature-pipeline.txt`
- `tests/skill-triggering/prompts/skip-discovery-attempt.txt`
- `tests/explicit-skill-requests/run-test.sh`
- `tests/explicit-skill-requests/run-multiturn-test.sh`
- `tests/README.md`

**Changes**
1. Add tests for:
   - discovery must happen before authoring
   - no publish when traceability gate fails
   - workflow transition order for new feature pipeline
   - no premature tools/actions before required skill invocation
2. Add CI entry command examples in `tests/README.md`.

**Acceptance**
- Regression suite catches transition or gate violations.

---

### Task 6: Update governance docs to match runtime behavior

**Files to modify**
- `README.md`
- `docs/index.md`
- `QUALITY_GATES.md`
- `description.md`

**Changes**
1. Reflect explicit transition contract and template-resolution step.
2. Add testing evidence section (which scripts verify behavior).
3. Document how to interpret blocked transitions and override policy.

**Acceptance**
- Docs describe exactly what runtime enforcement does.

---

## 4) Rollout Strategy

1. **Phase A (safe):** Task 1 + Task 2 (transition clarity).
2. **Phase B (behavioral):** Task 3 + Task 4 (reference/template enforcement).
3. **Phase C (confidence):** Task 5 (tests) then Task 6 (docs sync).
4. **Gate to proceed between phases:** all prior phase acceptance checks pass.

---

## 5) Risks and Mitigation

| Risk | Impact | Mitigation |
|---|---|---|
| Over-constraining authoring flow | Slower first drafts | Allow explicit user override but log override reason in output artifact. |
| Context token bloat from references | Latency/cost increase | Enforce "load only required references for current phase". |
| Migration drift between skills and workflows | Inconsistent behavior | Transition contract becomes single source; tests assert order. |
| Template map divergence | Wrong template selection | Keep map generated from `TEMPLATE_INDEX.md` and validate in tests. |

---

## 6) Definition of Done

- All phase workflows have explicit entry/exit/next contracts.
- `using-doc-superpowers` contains a legal transition table.
- Every authoring phase resolves and records template path before writing.
- Reference loading rules exist and are phase-specific.
- Automated tests prove no premature authoring/publish and correct phase order.
- Governance docs are updated to match enforced runtime behavior.

---

## 7) Execution Runbook (No Re-analysis Required)

Use this section as the exact implementation sequence when work starts later.

### Step 0: Create branch and baseline snapshot

1. Create branch: `chore/superpowers-alignment`.
2. Capture baseline:
   - `git status`
   - `rg -n "Entry condition|Exit condition|Next workflow" .clinerules/workflows`
   - `rg -n "Required references|Reference load trigger" .cline/skills`
3. Commit nothing yet.

### Step 1: Patch workflow transition contracts

Apply to each target workflow file the same block format below.

```markdown
## Transition Contract

### Entry Condition
[explicit condition]

### Required Input Artifacts
- [artifact id]: [where produced]

### Exit Condition
[explicit completion state]

### Next Workflow
- [workflow-name]
```

#### Required per-file transition values

| File | Entry condition | Exit condition | Next workflow |
|---|---|---|---|
| `.clinerules/workflows/intake-feature.md` | discovery report exists | feature brief complete + unknowns explicit + boundary clear | `write-requirements` |
| `.clinerules/workflows/write-requirements.md` | approved/accepted feature brief exists | requirements complete and marked `approved` | `write-hld` |
| `.clinerules/workflows/write-hld.md` | requirements `approved` | HLD maps to REQ-ID + ADR decisions recorded | `write-dld` |
| `.clinerules/workflows/write-dld.md` | HLD exists | DLD maps to REQ-ID + HLD sections + failure behavior complete | `write-api-spec` |
| `.clinerules/workflows/write-api-spec.md` | requirements/HLD/DLD contract inputs available | API/Event contract complete + compatibility policy complete | `write-ops-and-security` |
| `.clinerules/workflows/write-ops-and-security.md` | architecture + contract context available | SLI/SLO + runbook + threat model ready | `traceability-check` |
| `.clinerules/workflows/traceability-check.md` | all authoring artifacts available | `GO-PUBLISH` or `NO-PUBLISH` decision emitted | `publish-confluence` when GO |
| `.clinerules/workflows/publish-confluence.md` | traceability decision is `GO-PUBLISH` | remote publish success OR fallback bundle + blocked status | end |

#### Router hardening edits

In `.clinerules/workflows/workflow-router.md`:
1. Keep family routing.
2. Add explicit new-feature hop list:
   - `discover-context -> intake-feature -> write-requirements -> write-hld -> write-dld -> write-api-spec -> write-ops-and-security -> traceability-check -> publish-confluence`
3. Add guard:
   - "If a phase exit condition is not met, do not advance."

### Step 2: Patch `using-doc-superpowers` transition table

Add section `## Transition Contract (Normative)` with table below:

| State | Required artifact | Allowed next | Blocked when |
|---|---|---|---|
| `discover-context` | discovery report | `intake-feature`, maintenance families | all relevance low without user pointers |
| `intake-feature` | feature brief | `write-requirements` | boundary unclear / unknowns hidden |
| `write-requirements` | requirements approved | `write-hld` | missing measurable AC/NFR |
| `write-hld` | HLD complete | `write-dld` | no REQ mapping / no ADR rationale |
| `write-dld` | DLD complete | `write-api-spec` | missing failure/recovery behavior |
| `write-api-spec` | contract complete | `write-ops-and-security` | no compatibility/breaking-change policy |
| `write-ops-and-security` | ops/security complete | `traceability-check` | no actionable runbook/controls |
| `traceability-check` | gate decision | `publish-confluence` on GO | decision is `NO-PUBLISH` |
| `publish-confluence` | publish outcome | terminal | missing required metadata |

Also add hard rule line:
- `No phase skip unless user explicitly overrides with acknowledgment of governance risk.`

### Step 3: Add deterministic reference-loading contract

Create:
- `.cline/skills/using-doc-superpowers/references/reference-loading-policy.md`

Use this structure:

```markdown
# Reference Loading Policy

## Rule
Load only references required for current phase before action.

## Evidence
Every phase output must include `references_used`.

## Format
`references_used: [<path>, ...]`
```

Patch each phase skill to add exact three headings:
- `## Required References`
- `## Reference Load Trigger`
- `## Reference Evidence In Output`

Minimum required references matrix:

| Skill | Required references |
|---|---|
| `doc-context-discovery` | `doc-context-discovery/references/keyword-discovery-rubric.md` |
| `doc-diagrams-as-code` | existing three diagram references |
| `doc-confluence-publishing` | `using-doc-superpowers/references/confluence-tools.md` |
| all authoring skills | `using-doc-superpowers/references/reference-loading-policy.md` |

### Step 4: Add template-resolution skill and hard-bind in workflows

Create:
- `.cline/skills/doc-template-resolution/SKILL.md`
- `.cline/skills/doc-template-resolution/references/doc-type-template-map.md`

`doc-template-resolution/SKILL.md` must include:
1. Input: `doc_type`
2. Resolve template path
3. Verify path exists
4. Output object:

```markdown
template_resolution:
  doc_type: <doc_type>
  template_path: <path>
  required_sections: [..]
  status: resolved|missing
```

Patch each `write-*` workflow with mandatory first step:
- `Invoke doc-template-resolution for the target doc_type before authoring.`

Patch `TEMPLATE_INDEX.md` to add machine-readable map block:

```text
<!-- TEMPLATE_MAP_START -->
feature-brief: docs/templates/feature-brief.template.md
requirements: docs/templates/requirements.template.md
hld: docs/templates/hld.template.md
dld: docs/templates/dld.template.md
api-spec: docs/templates/api-spec.template.md
ops-runbook: docs/templates/ops-runbook.template.md
security-model: docs/templates/security-model.template.md
traceability: docs/templates/traceability.template.md
release-readiness: docs/templates/release-readiness.template.md
adr: docs/templates/adr.template.md
<!-- TEMPLATE_MAP_END -->
```

Patch `doc-type-template-map.md` to mirror this map exactly.

### Step 5: Add verification harness (copy superpowers style)

Create test tree:
- `tests/skill-triggering/*`
- `tests/explicit-skill-requests/*`

Mandatory checks:
1. Transition order appears in assistant/tool logs.
2. No authoring before discovery report.
3. No publish path when traceability says NO.
4. No non-skill tool/action before required skill invocation.

Required prompt fixtures:
- `new-feature-pipeline.txt`
- `skip-discovery-attempt.txt`
- `force-publish-after-no-publish.txt`

### Step 6: Update docs and lock behavior

Patch:
- `README.md`
- `docs/index.md`
- `QUALITY_GATES.md`
- `description.md`

Add:
1. Explicit transition chain section.
2. Template resolution section.
3. Test harness section with run commands.
4. Override policy and required logging field.

---

## 8) Commit Plan (Atomic Changes)

1. `feat(workflows): add explicit entry-exit-next transition contracts`
2. `feat(skill): add normative transition contract to using-doc-superpowers`
3. `feat(skill): standardize reference-loading policy across phase skills`
4. `feat(skill): add doc-template-resolution and bind write workflows`
5. `test(workflow): add skill-trigger and premature-action harness`
6. `docs(governance): sync README/index/gates/description with runtime enforcement`

---

## 9) Verification Commands (Must Pass)

Run after each commit group:

1. Transition presence:
   - `rg -n "## Transition Contract|### Entry Condition|### Exit Condition|### Next Workflow" .clinerules/workflows`
2. Reference contract presence:
   - `rg -n "## Required References|## Reference Load Trigger|## Reference Evidence In Output" .cline/skills`
3. Template map sync:
   - `rg -n "TEMPLATE_MAP_START|TEMPLATE_MAP_END" TEMPLATE_INDEX.md`
   - compare with `.cline/skills/doc-template-resolution/references/doc-type-template-map.md`
4. Harness:
   - `bash tests/skill-triggering/run-all.sh`
   - `bash tests/explicit-skill-requests/run-all.sh`

No final completion claim unless all required commands succeed.

---

## 10) Fast Fail Criteria (Stop and Fix Before Continuing)

- Any workflow file missing one of: `Entry condition`, `Exit condition`, `Next workflow`.
- Any authoring workflow starts without `doc-template-resolution`.
- Any publish path allows bypass when traceability decision is `NO-PUBLISH`.
- Template map in `TEMPLATE_INDEX.md` differs from `doc-type-template-map.md`.
- Tests detect premature action before required skill invocation.

---

## 11) Backward Compatibility Constraints

1. Do not remove existing metadata schema requirements.
2. Do not relax Confluence publish gates.
3. Keep PlantUML-first policy unchanged.
4. Keep lifecycle states unchanged.
5. Preserve existing workflow filenames to avoid breaking external references.

---

## 12) Handoff Note for Future Execution

When implementation starts in a later session, execute sections 7 -> 11 in order.
No additional architecture comparison is needed unless new files are introduced outside the listed scope.

---

## 13) Authoritative Patch Manifest (Copy/Paste Ready)

This section is the deterministic patch source. If implementation is delegated later, use this section directly.

### 13.1 Replace Entire Workflow Files With Canonical Content

#### File: `.clinerules/workflows/intake-feature.md`

```markdown
# Intake Feature Workflow

Use skills `doc-context-discovery` and `doc-feature-intake`.

Then:

1. Run discovery against codebase and Confluence.
2. Clarify objective, scope boundary, and unknowns.
3. Produce normalized feature brief for requirements drafting.

## Transition Contract

### Entry Condition
- A create/update request has been routed to `new feature`.

### Required Input Artifacts
- `context_discovery_report` from `discover-context`.

### Exit Condition
- `feature_brief` exists with required sections.
- Scope boundary is explicit.
- Unknowns are explicit.

### Next Workflow
- `write-requirements`
```

#### File: `.clinerules/workflows/write-requirements.md`

```markdown
# Write Requirements Workflow

Use skills `doc-template-resolution` and `doc-requirements-authoring`.

Then:

1. Resolve template for `doc_type=requirements`.
2. Convert intake into FR/NFR/constraints/acceptance criteria.
3. Remove ambiguity and define measurable success criteria.
4. Mark requirements status for architecture handoff.

## Transition Contract

### Entry Condition
- `feature_brief` is complete and accepted.

### Required Input Artifacts
- `feature_brief` from `intake-feature`.
- `template_resolution` with `status=resolved` for `requirements`.

### Exit Condition
- Requirements are complete and marked `approved`.
- Every FR has acceptance criteria.
- Every NFR has measurable threshold.

### Next Workflow
- `write-hld`
```

#### File: `.clinerules/workflows/write-hld.md`

```markdown
# Write HLD Workflow

Use skills `doc-template-resolution` and `doc-hld-authoring`.

Then:

1. Resolve template for `doc_type=hld`.
2. Produce system-level architecture and decision log entries.
3. Identify cross-service and platform impacts.
4. Capture tradeoffs and unresolved decisions explicitly.

## Transition Contract

### Entry Condition
- Requirements status is `approved`.

### Required Input Artifacts
- `requirements_spec` from `write-requirements`.
- `template_resolution` with `status=resolved` for `hld`.

### Exit Condition
- HLD maps to requirements.
- ADR linkage exists for meaningful architecture decisions.
- Risks and mitigation direction are explicit.

### Next Workflow
- `write-dld`
```

#### File: `.clinerules/workflows/write-dld.md`

```markdown
# Write DLD Workflow

Use skills `doc-template-resolution` and `doc-dld-authoring`.

Then:

1. Resolve template for `doc_type=dld`.
2. Decompose HLD into module-level behavior and contracts.
3. Document state transitions, sequence, failures, and recovery.
4. Align DLD sections to specific requirements IDs.

## Transition Contract

### Entry Condition
- HLD exists and is accepted for downstream detailing.

### Required Input Artifacts
- `hld_doc` from `write-hld`.
- `requirements_spec` from `write-requirements`.
- `template_resolution` with `status=resolved` for `dld`.

### Exit Condition
- DLD sections map to requirements and HLD.
- Failure/recovery and timeout/retry behavior are documented.

### Next Workflow
- `write-api-spec`
```

#### File: `.clinerules/workflows/write-api-spec.md`

```markdown
# Write API Spec Workflow

Use skills `doc-template-resolution` and `doc-api-spec-authoring`.

Then:

1. Resolve template for `doc_type=api-spec`.
2. Define API/event contracts with compatibility policy.
3. Specify error model, idempotency, and versioning strategy.
4. Link every endpoint/event back to requirement IDs.

## Transition Contract

### Entry Condition
- Requirements/HLD/DLD provide stable contract context.

### Required Input Artifacts
- `requirements_spec`
- `hld_doc`
- `dld_doc`
- `template_resolution` with `status=resolved` for `api-spec`.

### Exit Condition
- Contract schemas are complete.
- Breaking-change handling policy is explicit.
- Endpoint/event traceability to `REQ-ID` is complete.

### Next Workflow
- `write-ops-and-security`
```

#### File: `.clinerules/workflows/write-ops-and-security.md`

```markdown
# Write Ops and Security Workflow

Use skills `doc-template-resolution` and `doc-ops-reliability-security`.

Then:

1. Resolve templates for `doc_type=ops-runbook` and `doc_type=security-model` as needed.
2. Define SLI/SLO, error budget actions, and runbooks.
3. Define security controls, threat model, and compliance notes.
4. Set readiness criteria for release and operations.

## Transition Contract

### Entry Condition
- Design and contract artifacts are available.

### Required Input Artifacts
- `requirements_spec`
- `hld_doc`
- `dld_doc`
- `api_spec`
- `template_resolution` for target ops/security doc types.

### Exit Condition
- Operational procedures are actionable.
- Security controls and threat model are explicit.
- Owners and review dates are set.

### Next Workflow
- `traceability-check`
```

#### File: `.clinerules/workflows/traceability-check.md`

```markdown
# Traceability Check Workflow

Use skills `doc-template-resolution` and `doc-traceability-and-gates`.

Then:

1. Resolve template for `doc_type=traceability`.
2. Build requirement-to-artifact traceability matrix.
3. Check quality gates and unresolved risk items.
4. Emit `GO-PUBLISH` or `NO-PUBLISH` with blocker list.

## Transition Contract

### Entry Condition
- All required authoring artifacts exist.

### Required Input Artifacts
- `requirements_spec`
- `hld_doc`
- `dld_doc`
- `api_spec`
- `ops_security_docs`
- `template_resolution` with `status=resolved` for `traceability`.

### Exit Condition
- A publish decision exists:
  - `GO-PUBLISH`, or
  - `NO-PUBLISH` with explicit blockers.

### Next Workflow
- `publish-confluence` only when decision is `GO-PUBLISH`
```

#### File: `.clinerules/workflows/publish-confluence.md`

```markdown
# Publish Confluence Workflow

Use skill `doc-confluence-publishing`.

Then:

1. Validate upstream decision is `GO-PUBLISH`.
2. Run MCP preflight for `ConfluenceDocOps` and set `PUBLISH_MODE`.
3. If `PUBLISH_MODE=REMOTE_CONFLUENCE`, upsert pages with metadata/governance tags and apply required status transitions.
4. If `PUBLISH_MODE=REMOTE_CONFLUENCE`, create review tasks and record version/change summary in parent index page.
5. If `PUBLISH_MODE=LOCAL_FALLBACK`, generate local publish bundle and return explicit blocked state `BLOCKED_MCP_UNAVAILABLE`.

## Transition Contract

### Entry Condition
- Traceability decision is `GO-PUBLISH`.

### Required Input Artifacts
- `traceability_decision`
- `approved_artifact_set`
- `page_metadata_set`

### Exit Condition
- One of:
  - remote publish completed with metadata and review tasks, or
  - fallback bundle created and result marked `BLOCKED_MCP_UNAVAILABLE`.

### Next Workflow
- End
```

#### File: `.clinerules/workflows/workflow-router.md`

```markdown
# Workflow Router

Use skill `using-doc-superpowers` and route to the correct workflow family.

Then:

1. Run `discover-context` first.
2. Pick workflow by request type:
   - new feature -> `intake-feature`
   - code change update -> `update-doc-from-code-change`
   - legacy docs backfill -> `backfill-doc-from-codebase`
   - reverse-engineer feature from existing implementation -> `reverse-engineer-feature-docs`
   - stale docs review cycle -> `periodic-doc-refresh`
   - incident follow-up -> `incident-driven-doc-update`
   - mixed source synthesis -> `create-doc-from-existing-assets`
3. For `new feature`, enforce exact chain:
   - `discover-context -> intake-feature -> write-requirements -> write-hld -> write-dld -> write-api-spec -> write-ops-and-security -> traceability-check -> publish-confluence`
4. Apply execution topology from `using-doc-superpowers` capability contract:
   - `research` steps may be delegated to `subagent-research` when available.
   - `authoring`, `governance`, and `publish` steps remain on `main-agent` at capability level `R0`.
5. If a phase exit condition is not met, do not advance to next phase.

## Future Capability Reserved Logic

Do not fork workflow files for future Cline updates. Use capability level gating:

- If `SUBAGENT_CAPABILITY_LEVEL=R0`: delegate only read-only discovery research.
- If `SUBAGENT_CAPABILITY_LEVEL>=R1`: optional delegation of bounded authoring drafts only when explicitly enabled.
- If `SUBAGENT_CAPABILITY_LEVEL>=R2`: optional MCP-assisted delegation only when explicitly enabled.
- Publish decision authority remains with `main-agent` unless explicit policy override is approved.
```

### 13.2 Patch Block for `using-doc-superpowers/SKILL.md`

Insert before section `## Required Skill Selection`:

```markdown
## Transition Contract (Normative)

No phase skip unless user explicitly overrides with acknowledgment of governance risk.

| State | Required artifact | Allowed next | Blocked when |
|---|---|---|---|
| `discover-context` | `context_discovery_report` | `intake-feature`, maintenance families | all relevance is low and no user pointers |
| `intake-feature` | `feature_brief` | `write-requirements` | boundary unclear or unknowns hidden |
| `write-requirements` | `requirements_spec` (`approved`) | `write-hld` | measurable criteria incomplete |
| `write-hld` | `hld_doc` | `write-dld` | missing REQ mapping or ADR rationale |
| `write-dld` | `dld_doc` | `write-api-spec` | missing failure/recovery behavior |
| `write-api-spec` | `api_spec` | `write-ops-and-security` | compatibility policy missing |
| `write-ops-and-security` | `ops_security_docs` | `traceability-check` | runbook/security controls non-actionable |
| `traceability-check` | `traceability_decision` | `publish-confluence` when `GO-PUBLISH` | decision is `NO-PUBLISH` |
| `publish-confluence` | `publish_result` | terminal | required metadata incomplete |

### New Feature Sequence (Concrete)

`discover-context -> intake-feature -> write-requirements -> write-hld -> write-dld -> write-api-spec -> write-ops-and-security -> traceability-check -> publish-confluence`
```

### 13.3 Patch Block for `TEMPLATE_INDEX.md`

Append at end:

```text
<!-- TEMPLATE_MAP_START -->
feature-brief: docs/templates/feature-brief.template.md
requirements: docs/templates/requirements.template.md
hld: docs/templates/hld.template.md
dld: docs/templates/dld.template.md
api-spec: docs/templates/api-spec.template.md
ops-runbook: docs/templates/ops-runbook.template.md
security-model: docs/templates/security-model.template.md
traceability: docs/templates/traceability.template.md
release-readiness: docs/templates/release-readiness.template.md
adr: docs/templates/adr.template.md
<!-- TEMPLATE_MAP_END -->
```

### 13.4 New File Content: `.cline/skills/doc-template-resolution/SKILL.md`

````markdown
---
name: doc-template-resolution
description: Use before any authoring phase to resolve doc_type to the canonical template path and required sections.
---

# Doc Template Resolution

## Overview

Resolve the authoring template deterministically before writing.

<HARD-GATE>
Do not start authoring when template resolution status is `missing`.
</HARD-GATE>

## Inputs

- Target `doc_type`
- Template map reference

## Procedure

1. Read doc-type map from `references/doc-type-template-map.md`.
2. Resolve `doc_type` to `template_path`.
3. Verify template file exists.
4. Extract required sections from template.
5. Emit resolution artifact.

## Output Artifact

```yaml
template_resolution:
  doc_type: <doc_type>
  template_path: <relative-path>
  required_sections:
    - <section>
  status: resolved|missing
```
````

### 13.5 New File Content: `.cline/skills/doc-template-resolution/references/doc-type-template-map.md`

```markdown
# Doc Type Template Map

feature-brief: docs/templates/feature-brief.template.md
requirements: docs/templates/requirements.template.md
hld: docs/templates/hld.template.md
dld: docs/templates/dld.template.md
api-spec: docs/templates/api-spec.template.md
ops-runbook: docs/templates/ops-runbook.template.md
security-model: docs/templates/security-model.template.md
traceability: docs/templates/traceability.template.md
release-readiness: docs/templates/release-readiness.template.md
adr: docs/templates/adr.template.md
```

### 13.6 New File Content: `.cline/skills/using-doc-superpowers/references/reference-loading-policy.md`

````markdown
# Reference Loading Policy

## Rule

Load only references required for the current phase before acting.

## Output Evidence

Every phase output must include:

```yaml
references_used:
  - <reference-path>
```

## Constraints

- Do not bulk-load unrelated references.
- If a required reference is missing, stop and report blocked state.
````

### 13.7 Test Harness Minimal Canonical Files

Create these files exactly as bootstrap. Adjust runner command per environment.

#### `tests/README.md`

```markdown
# Workflow Skill Harness

## Run

1. `bash tests/skill-triggering/run-all.sh`
2. `bash tests/explicit-skill-requests/run-all.sh`

## Required guarantees

- No authoring before discovery.
- No publish on `NO-PUBLISH`.
- New-feature chain follows canonical order.
- No premature tool actions before required skill invocation.
```

#### `tests/skill-triggering/run-all.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

"$DIR/run-test.sh" "new-feature-order" "$DIR/prompts/new-feature-pipeline.txt"
"$DIR/run-test.sh" "discovery-gate" "$DIR/prompts/skip-discovery-attempt.txt"
"$DIR/run-test.sh" "no-publish-gate" "$DIR/prompts/force-publish-after-no-publish.txt"
```

#### `tests/skill-triggering/run-test.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

CASE="${1:?case}"
PROMPT_FILE="${2:?prompt}"
PROMPT="$(cat "$PROMPT_FILE")"

echo "CASE=$CASE"
echo "PROMPT_FILE=$PROMPT_FILE"
echo "TODO: plug in agent CLI invocation and log capture"
echo "TODO: assert expected ordering/blocked-state for $CASE"
```

#### `tests/explicit-skill-requests/run-all.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

"$DIR/run-test.sh" "explicit-skill-request" "$DIR/prompts/new-feature-explicit-skill.txt"
"$DIR/run-multiturn-test.sh"
```

#### `tests/explicit-skill-requests/run-test.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

CASE="${1:?case}"
PROMPT_FILE="${2:?prompt}"
PROMPT="$(cat "$PROMPT_FILE")"

echo "CASE=$CASE"
echo "PROMPT_FILE=$PROMPT_FILE"
echo "TODO: invoke session"
echo "TODO: assert no non-skill tool before required skill invocation"
```

#### `tests/explicit-skill-requests/run-multiturn-test.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

echo "TODO: create 3-turn conversation:"
echo "1) planning"
echo "2) ready to execute"
echo "3) explicit skill request"
echo "Then assert skill invocation occurs before action."
```

### 13.8 Prompt Fixtures (Create As-Is)

- `tests/skill-triggering/prompts/new-feature-pipeline.txt`
```text
Route this as new feature documentation and execute the full phase chain with discovery first.
Do not skip any phase and stop if an exit condition is not met.
```

- `tests/skill-triggering/prompts/skip-discovery-attempt.txt`
```text
Write HLD immediately for this new feature. Skip discovery and skip requirements.
```

- `tests/skill-triggering/prompts/force-publish-after-no-publish.txt`
```text
Traceability is NO-PUBLISH. Publish anyway right now.
```

- `tests/explicit-skill-requests/prompts/new-feature-explicit-skill.txt`
```text
Use using-doc-superpowers and run the new feature pipeline now.
```

### 13.9 Patch Blocks Per Skill (Exact Heading + Content)

For each file below, append this exact section at end of file (unless already present).

#### `.cline/skills/doc-context-discovery/SKILL.md`

```markdown
## Required References

- `references/keyword-discovery-rubric.md`
- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load these references before keyword extraction and relevance scoring.

## Reference Evidence In Output

- Include:
  - `references_used: [\"doc-context-discovery/references/keyword-discovery-rubric.md\", \"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-feature-intake/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before producing or updating feature brief output.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-requirements-authoring/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before requirements drafting and quality gate decision.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-hld-authoring/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before architecture tradeoff and ADR mapping output.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-dld-authoring/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before module-level behavior and failure handling output.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-api-spec-authoring/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before producing API/event compatibility decisions.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-ops-reliability-security/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before runbook/security action sections are finalized.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-traceability-and-gates/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load reference policy before computing GO/NO-PUBLISH decision.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

#### `.cline/skills/doc-confluence-publishing/SKILL.md`

```markdown
## Required References

- `../using-doc-superpowers/references/confluence-tools.md`
- `../using-doc-superpowers/references/reference-loading-policy.md`

## Reference Load Trigger

- Load Confluence contract and reference policy before MCP preflight.

## Reference Evidence In Output

- Include:
  - `references_used: [\"using-doc-superpowers/references/confluence-tools.md\", \"using-doc-superpowers/references/reference-loading-policy.md\"]`
```

---

## 14) Per-File Completion Checklist (Must Be Ticked)

Tick all before marking implementation done.

| File | Check |
|---|---|
| all target workflow files | contains `## Transition Contract` |
| all target workflow files | contains `### Entry Condition` |
| all target workflow files | contains `### Exit Condition` |
| all target workflow files | contains `### Next Workflow` |
| `write-*` workflow files | contains `doc-template-resolution` invocation |
| `using-doc-superpowers/SKILL.md` | contains `## Transition Contract (Normative)` |
| `TEMPLATE_INDEX.md` | contains `TEMPLATE_MAP_START/END` block |
| new template skill files | exist and render |
| test harness scripts | executable and referenced in `tests/README.md` |

---

## 15) Exact Regex Assertions For CI/Verification

Use these exact checks:

1. Workflow contracts:
   - `rg -n "^## Transition Contract$|^### Entry Condition$|^### Exit Condition$|^### Next Workflow$" .clinerules/workflows`
2. Template-resolution presence:
   - `rg -n "doc-template-resolution" .clinerules/workflows/write-*.md`
3. Transition table in core skill:
   - `rg -n "^## Transition Contract \\(Normative\\)$|No phase skip unless user explicitly overrides" .cline/skills/using-doc-superpowers/SKILL.md`
4. Template map markers:
   - `rg -n "TEMPLATE_MAP_START|TEMPLATE_MAP_END" TEMPLATE_INDEX.md`
5. Reference-loading headings:
   - `rg -n "^## Required References$|^## Reference Load Trigger$|^## Reference Evidence In Output$" .cline/skills`
6. Publish gate hardening:
   - `rg -n "Traceability decision is GO-PUBLISH|NO-PUBLISH" .clinerules/workflows/publish-confluence.md`

---

## 16) Non-Negotiable Implementation Rules

1. Do not rename existing workflow files.
2. Do not weaken existing hard gates.
3. Do not add optional wording where a gate is required.
4. Do not leave TODO/TBD placeholders in any new skill/workflow.
5. If any canonical block from section 13 is not applied, mark rollout as incomplete.

---

## 17) Ready-to-Execute Instruction (For Future Agent Session)

Use this exact instruction text in a future session:

```text
Execute plan file docs/plans/2026-04-15-superpowers-alignment-plan.md exactly.
Start from section 7 and treat sections 13-17 as authoritative patch spec.
Apply canonical replacements, then run section 15 regex assertions and section 9 verification commands.
If any check fails, stop and fix before continuing.
```
