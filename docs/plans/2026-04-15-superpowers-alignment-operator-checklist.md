# Superpowers Alignment Operator Checklist

Use with:
- `docs/plans/2026-04-15-superpowers-alignment-plan.md`

Goal:
- Execute alignment work without re-analysis.

---

## 0) Preconditions

- [ ] Work on branch: `chore/superpowers-alignment`
- [ ] Baseline captured:
  - [ ] `git status`
  - [ ] `rg -n "Entry condition|Exit condition|Next workflow" .clinerules/workflows`
  - [ ] `rg -n "Required references|Reference load trigger" .cline/skills`

---

## 1) Apply Canonical Workflow Replacements

- [ ] Replace full content (from plan section 13.1) for:
  - [ ] `.clinerules/workflows/workflow-router.md`
  - [ ] `.clinerules/workflows/intake-feature.md`
  - [ ] `.clinerules/workflows/write-requirements.md`
  - [ ] `.clinerules/workflows/write-hld.md`
  - [ ] `.clinerules/workflows/write-dld.md`
  - [ ] `.clinerules/workflows/write-api-spec.md`
  - [ ] `.clinerules/workflows/write-ops-and-security.md`
  - [ ] `.clinerules/workflows/traceability-check.md`
  - [ ] `.clinerules/workflows/publish-confluence.md`

---

## 2) Patch Core Transition Contract

- [ ] Insert `## Transition Contract (Normative)` block (plan section 13.2) into:
  - [ ] `.cline/skills/using-doc-superpowers/SKILL.md`
- [ ] Confirm includes:
  - [ ] State table
  - [ ] New feature sequence
  - [ ] Rule: no phase skip without explicit override

---

## 3) Add Reference-Loading Policy

- [ ] Create file with canonical content (plan section 13.6):
  - [ ] `.cline/skills/using-doc-superpowers/references/reference-loading-policy.md`
- [ ] Append canonical reference headings/blocks (plan section 13.9) to:
  - [ ] `.cline/skills/doc-context-discovery/SKILL.md`
  - [ ] `.cline/skills/doc-feature-intake/SKILL.md`
  - [ ] `.cline/skills/doc-requirements-authoring/SKILL.md`
  - [ ] `.cline/skills/doc-hld-authoring/SKILL.md`
  - [ ] `.cline/skills/doc-dld-authoring/SKILL.md`
  - [ ] `.cline/skills/doc-api-spec-authoring/SKILL.md`
  - [ ] `.cline/skills/doc-ops-reliability-security/SKILL.md`
  - [ ] `.cline/skills/doc-traceability-and-gates/SKILL.md`
  - [ ] `.cline/skills/doc-confluence-publishing/SKILL.md`

---

## 4) Add Template Resolution Skill

- [ ] Create with canonical content (plan section 13.4):
  - [ ] `.cline/skills/doc-template-resolution/SKILL.md`
- [ ] Create with canonical content (plan section 13.5):
  - [ ] `.cline/skills/doc-template-resolution/references/doc-type-template-map.md`
- [ ] Append map block in `TEMPLATE_INDEX.md` (plan section 13.3):
  - [ ] `<!-- TEMPLATE_MAP_START --> ... <!-- TEMPLATE_MAP_END -->`

---

## 5) Add Harness Bootstrap

- [ ] Create files from plan section 13.7:
  - [ ] `tests/README.md`
  - [ ] `tests/skill-triggering/run-all.sh`
  - [ ] `tests/skill-triggering/run-test.sh`
  - [ ] `tests/explicit-skill-requests/run-all.sh`
  - [ ] `tests/explicit-skill-requests/run-test.sh`
  - [ ] `tests/explicit-skill-requests/run-multiturn-test.sh`
- [ ] Create prompt fixtures from plan section 13.8:
  - [ ] `tests/skill-triggering/prompts/new-feature-pipeline.txt`
  - [ ] `tests/skill-triggering/prompts/skip-discovery-attempt.txt`
  - [ ] `tests/skill-triggering/prompts/force-publish-after-no-publish.txt`
  - [ ] `tests/explicit-skill-requests/prompts/new-feature-explicit-skill.txt`

---

## 6) Verification Commands (Must Pass)

- [ ] `rg -n "^## Transition Contract$|^### Entry Condition$|^### Exit Condition$|^### Next Workflow$" .clinerules/workflows`
- [ ] `rg -n "doc-template-resolution" .clinerules/workflows/write-*.md`
- [ ] `rg -n "^## Transition Contract \\(Normative\\)$|No phase skip unless user explicitly overrides" .cline/skills/using-doc-superpowers/SKILL.md`
- [ ] `rg -n "TEMPLATE_MAP_START|TEMPLATE_MAP_END" TEMPLATE_INDEX.md`
- [ ] `rg -n "^## Required References$|^## Reference Load Trigger$|^## Reference Evidence In Output$" .cline/skills`
- [ ] `rg -n "Traceability decision is GO-PUBLISH|NO-PUBLISH" .clinerules/workflows/publish-confluence.md`

Optional runtime harness:
- [ ] `bash tests/skill-triggering/run-all.sh`
- [ ] `bash tests/explicit-skill-requests/run-all.sh`

---

## 7) Atomic Commit Sequence

- [ ] `feat(workflows): add explicit entry-exit-next transition contracts`
- [ ] `feat(skill): add normative transition contract to using-doc-superpowers`
- [ ] `feat(skill): standardize reference-loading policy across phase skills`
- [ ] `feat(skill): add doc-template-resolution and bind write workflows`
- [ ] `test(workflow): add skill-trigger and premature-action harness`
- [ ] `docs(governance): sync README/index/gates/description with runtime enforcement`

---

## 8) Stop Conditions (Do Not Proceed)

- [ ] Any target workflow missing Transition Contract headings
- [ ] Any authoring flow missing template-resolution step
- [ ] Publish workflow allows bypass after `NO-PUBLISH`
- [ ] Template map mismatch between `TEMPLATE_INDEX.md` and doc-type map
- [ ] Any TODO/TBD placeholder remains in new canonical blocks

---

## 9) Done Criteria

- [ ] All checkboxes above are complete
- [ ] Verification commands pass
- [ ] No fast-fail condition present
- [ ] Changes documented and committed
