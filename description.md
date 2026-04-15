# Mo ta he thong doc-management

## Pham vi da tong hop

- Nguon: toan bo `C:\Users\Admin\Desktop\workspace\doc-management` (skills, workflow, governance, templates, hooks, changelog).
- Trong tam: mo hinh van hanh discovery-first, workflow toi thieu 1 entrypoint, core-4 mac dinh va nhanh optional theo yeu cau.

## 1) Workflow toi thieu: `document-management`

Workflow runtime duy nhat:

- `.clinerules/workflows/document-management.md`

Workflow nay dieu phoi skill theo 2 mode chinh:

1. `new-feature`
2. `update-existing` (dua tren codebase + tai lieu da co + yeu cau user)

## 2) Luong `new-feature` (core-4)

1. `doc-context-discovery`
2. `doc-feature-intake` -> tao `feature-brief`
3. `doc-requirements-authoring` -> tao `requirements`
4. `doc-hld-authoring` -> tao `hld`
5. `doc-dld-authoring` -> tao `dld`
6. Chay gate bat buoc theo scope (`G0 -> G1 -> G2 -> G3`)
7. Neu co yeu cau publish thi chay `doc-confluence-publishing` voi `G7`

Core-4 la luong mac dinh. Khong tu dong mo rong sang API/Ops/Security/Traceability neu chua co yeu cau.

## 3) Luong `update-existing`

1. `doc-context-discovery` de lay evidence codebase + Confluence
2. `doc-lifecycle-management` de quyet dinh update-in-place/version/deprecate
3. Cap nhat dung artifact/section bi anh huong bang cac skill phase (`requirements`, `hld`, `dld`) khi can
4. Chay gate scope phu hop truoc publish
5. Neu co yeu cau publish thi chay `doc-confluence-publishing`

## 4) Artifact optional (chi tao khi duoc yeu cau hoac scope bat buoc)

| Artifact | Skill | Khi nao bat dau |
|---|---|---|
| `api-spec` | `doc-api-spec-authoring` | Co thay doi hoac yeu cau contract API/Event |
| `ops-runbook` | `doc-ops-reliability-security` | Co nhu cau van hanh, release, incident readiness |
| `security-model` | `doc-ops-reliability-security` | Co yeu cau security/compliance |
| `traceability` | `doc-traceability-and-gates` | Can governance artifact rieng hoac review gate chuyen sau |
| `release-readiness` | theo template + gate | Can checklist release formal |
| `adr` | theo template + HLD tradeoff | Co quyet dinh kien truc can ghi nhan |

## 5) Gate ap dung theo scope

- Bat buoc core flow: `G0`, `G1`, `G2`, `G3`
- Conditional:
  - `G4` khi co `api-spec`
  - `G5` khi co `ops-runbook`/`security-model`
  - `G6` khi co traceability/governance artifact rieng
  - `G7` khi publish/update Confluence
  - `G8` khi update-existing theo kieu reverse/backfill tu code hien huu

## 6) Template scope

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

## 7) Luu y van hanh quan trong

- Van giu nguyen nguyen tac discovery-first.
- Van giu nguyen metadata schema khi publish (`doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`).
- `traceability_ref` co the la link trang traceability rieng hoac inline reference key trong core-4 mode.
- PlantUML van la mac dinh cho diagram-as-code; Mermaid chi fallback khi co ly do ro rang.
