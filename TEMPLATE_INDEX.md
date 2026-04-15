# TEMPLATE_INDEX

Danh muc template tai lieu cho software development docs.

## 1) Mapping `doc_type` -> template

| `doc_type` | Template | Scope | Dung khi |
|---|---|---|---|
| `feature-brief` | `docs/templates/feature-brief.template.md` | Default | Chuan hoa dau bai feature truoc requirements |
| `requirements` | `docs/templates/requirements.template.md` | Default | Viet FR/NFR/acceptance criteria |
| `hld` | `docs/templates/hld.template.md` | Default | Thiet ke cap he thong |
| `dld` | `docs/templates/dld.template.md` | Default | Thiet ke cap module/flow chi tiet |
| `api-spec` | `docs/templates/api-spec.template.md` | Optional | Dac ta API/Event contract khi co yeu cau |
| `ops-runbook` | `docs/templates/ops-runbook.template.md` | Optional | Van hanh, incident, rollback khi can |
| `security-model` | `docs/templates/security-model.template.md` | Optional | Threat model va control mapping khi can |
| `traceability` | `docs/templates/traceability.template.md` | Optional | Matrix truy vet end-to-end khi workflow governance yeu cau |
| `release-readiness` | `docs/templates/release-readiness.template.md` | Optional | Checklist readiness truoc release khi can |
| `adr` | `docs/templates/adr.template.md` | Optional | Ghi nhan quyet dinh kien truc khi can |

## 2) Quy tac dung template

1. Khong bo phan metadata.
2. Khong bo section bat buoc cua template.
3. Neu section "N/A", phai ghi ro ly do.
4. Neu doi template, cap nhat lai `TEMPLATE_INDEX.md`.

## 3) Trinh tu khuyen nghi

Default (core-4):

`feature-brief -> requirements -> hld -> dld`

Optional extension (chi khi duoc yeu cau):

`api-spec` / `ops-runbook + security-model` / `traceability` / `release-readiness` / `adr`

Publish duoc thuc hien khi cac gate bat buoc cho scope hien tai da pass.
