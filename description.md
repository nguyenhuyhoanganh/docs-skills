# Mo ta he thong doc-management

## Pham vi da tong hop

- Nguon: toan bo `C:\Users\Admin\Desktop\workspace\doc-management` (skills, workflows, governance, templates, hooks, changelog).
- Trong tam: mo hinh van hanh mac dinh core-4 docs va cac nhanh optional theo yeu cau.

## 1) Luong mac dinh cho feature moi (core-4)

1. `doc-context-discovery`
2. `doc-feature-intake` -> tao `feature-brief`
3. `doc-requirements-authoring` -> tao `requirements`
4. `doc-hld-authoring` -> tao `hld`
5. `doc-dld-authoring` -> tao `dld`
6. Chay gate bat buoc theo scope (`G0 -> G1 -> G2 -> G3`)
7. Neu co yeu cau publish thi chay `publish-confluence` voi `G7`

Core-4 la luong mac dinh. Khong tu dong mo rong sang API/Ops/Security/Traceability neu chua co yeu cau.

## 2) Artifact optional (chi tao khi duoc yeu cau hoac scope bat buoc)

| Artifact | Skill/Workflow | Khi nao bat dau |
|---|---|---|
| `api-spec` | `doc-api-spec-authoring` / `write-api-spec` | Co thay doi hoac yeu cau contract API/Event |
| `ops-runbook` | `doc-ops-reliability-security` / `write-ops-and-security` | Co nhu cau van hanh, release, incident readiness |
| `security-model` | `doc-ops-reliability-security` / `write-ops-and-security` | Co yeu cau security/compliance |
| `traceability` | `doc-traceability-and-gates` / `traceability-check` | Can governance artifact rieng hoac review gate chuyen sau |
| `release-readiness` | theo template + gate | Can checklist release formal |
| `adr` | theo template + HLD tradeoff | Co quyet dinh kien truc can ghi nhan |

## 3) Catalog workflow (tom tat)

- `workflow-router`: route yeu cau vao dung workflow family.
- `discover-context`: bat buoc truoc moi create/update.
- `intake-feature`: chuan hoa feature brief.
- `write-requirements`, `write-hld`, `write-dld`: chuoi core-4.
- `write-api-spec`, `write-ops-and-security`, `traceability-check`: nhanh optional.
- `publish-confluence`: publish co preflight MCP + governance.
- `update-doc-from-code-change`, `update-existing-docs`, `periodic-doc-refresh`, `incident-driven-doc-update`: cac luong bao tri.
- `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`, `create-doc-from-existing-assets`: luong tong hop/legacy/reverse-engineering.

## 4) Gate ap dung theo scope

- Bat buoc core flow: `G0`, `G1`, `G2`, `G3`
- Conditional:
  - `G4` khi co `api-spec`
  - `G5` khi co `ops-runbook`/`security-model`
  - `G6` khi co traceability/governance artifact rieng
  - `G7` khi publish/update Confluence
  - `G8` cho reverse-engineering/backfill

## 5) Template scope

Core templates:

- `docs/templates/feature-brief.template.md`
- `docs/templates/requirements.template.md`
- `docs/templates/hld.template.md`
- `docs/templates/dld.template.md`

Optional templates:

- `docs/templates/api-spec.template.md`
- `docs/templates/ops-runbook.template.md`
- `docs/templates/security-model.template.md`
- `docs/templates/traceability.template.md`
- `docs/templates/release-readiness.template.md`
- `docs/templates/adr.template.md`

## 6) Luu y van hanh quan trong

- Van giu nguyen nguyen tac discovery-first.
- Van giu nguyen metadata schema khi publish (`doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`).
- `traceability_ref` co the la link trang traceability rieng hoac inline reference key trong core-4 mode.
- PlantUML van la mac dinh cho diagram-as-code; Mermaid chi fallback khi co ly do ro rang.
