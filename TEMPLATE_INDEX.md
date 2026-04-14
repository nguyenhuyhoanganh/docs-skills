# TEMPLATE_INDEX

Danh mục template tài liệu cho software development docs.

## 1) Mapping `doc_type` -> template

| `doc_type` | Template | Dùng khi |
|---|---|---|
| `feature-brief` | `docs/templates/feature-brief.template.md` | Chuẩn hóa đầu bài feature trước requirements |
| `requirements` | `docs/templates/requirements.template.md` | Viết FR/NFR/acceptance criteria |
| `hld` | `docs/templates/hld.template.md` | Thiết kế cấp hệ thống |
| `dld` | `docs/templates/dld.template.md` | Thiết kế cấp module/flow chi tiết |
| `api-spec` | `docs/templates/api-spec.template.md` | Đặc tả API/Event contract |
| `ops-runbook` | `docs/templates/ops-runbook.template.md` | Vận hành, incident, rollback |
| `security-model` | `docs/templates/security-model.template.md` | Threat model và control mapping |
| `traceability` | `docs/templates/traceability.template.md` | Matrix truy vết end-to-end |
| `release-readiness` | `docs/templates/release-readiness.template.md` | Checklist readiness trước release |
| `adr` | `docs/templates/adr.template.md` | Ghi nhận quyết định kiến trúc |

## 2) Quy tắc dùng template

1. Không bỏ phần metadata.
2. Không bỏ section bắt buộc của template.
3. Nếu section "N/A", phải ghi rõ lý do.
4. Nếu đổi template, cập nhật lại `TEMPLATE_INDEX.md`.

## 3) Trình tự khuyến nghị

`feature-brief -> requirements -> hld -> dld -> api-spec -> ops/security -> traceability -> release-readiness -> publish`
