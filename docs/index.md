# Documentation Index

Mục tiêu của bộ tài liệu này là chuẩn hóa tài liệu phát triển phần mềm theo mô hình `discovery-first`, `traceability-driven`, và `publish governance`.

## 1) Get Started

- [README](../README.md): Tổng quan nhanh.
- [Mô tả chi tiết hệ thống](../MO_TA_CHI_TIET_HE_THONG_TAI_LIEU_VI.md): Bản mô tả đầy đủ skill/workflow.
- [Benchmark nguồn tham chiếu](./benchmark-skill-sources.md): Nguồn chuẩn từ Gemini/OpenAI/Anthropic/PlantUML/SRE/C4.

## 2) Governance (Bắt buộc đọc)

- [DOCS_CONTRIBUTING](../DOCS_CONTRIBUTING.md): Quy trình đóng góp và cập nhật tài liệu.
- [DOCS_STYLEGUIDE](../DOCS_STYLEGUIDE.md): Quy chuẩn viết tài liệu.
- [QUALITY_GATES](../QUALITY_GATES.md): Gate chất lượng theo phase.
- [TEMPLATE_INDEX](../TEMPLATE_INDEX.md): Danh mục template theo `doc_type`.

## 3) Skill & Workflow Surface

- Workflows: `.clinerules/workflows/*`
- Skills: `.cline/skills/*`
- Bootstrap hook: `.clinerules/hooks/TaskStart(.ps1)`
- New reverse-engineer workflow: `.clinerules/workflows/reverse-engineer-feature-docs.md`

## 4) Template Library

Các template chính cho software documentation:

- `docs/templates/feature-brief.template.md`
- `docs/templates/requirements.template.md`
- `docs/templates/hld.template.md`
- `docs/templates/dld.template.md`
- `docs/templates/api-spec.template.md`
- `docs/templates/ops-runbook.template.md`
- `docs/templates/security-model.template.md`
- `docs/templates/traceability.template.md`
- `docs/templates/release-readiness.template.md`
- `docs/templates/adr.template.md`

## 5) Releases

- [Changelog Index](./changelog/index.md)
- [Latest](./changelog/latest.md)

## 6) Quy tắc vận hành nhanh

1. Route yêu cầu vào workflow family phù hợp (`workflow-router`).
2. Chạy discovery trước mọi create/update.
3. Viết tài liệu theo template tương ứng.
4. Chạy `traceability-check` trước publish.
5. Publish với metadata đầy đủ và reviewer assignment.
6. Với reverse-engineering từ code hiện hữu, áp dụng thêm gate consistency theo `QUALITY_GATES.md` (G8).
