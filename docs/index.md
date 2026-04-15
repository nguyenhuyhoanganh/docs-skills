# Documentation Index

Muc tieu cua bo tai lieu nay la chuan hoa tai lieu phat trien phan mem theo mo hinh `discovery-first`, `core-4-first`, va `publish governance`.

> User-facing reference only: trang nay khong phai runtime instruction surface cua Cline.

## 1) Get Started

- [README](../README.md): Tong quan nhanh.
- [Mo ta chi tiet he thong](../description.md): Ban mo ta day du skill/workflow.
- [Benchmark nguon tham chieu](./benchmark-skill-sources.md): Nguon chuan tu Gemini/OpenAI/Anthropic/PlantUML/SRE/C4.

## 2) Governance (Bat buoc doc)

- [DOCS_CONTRIBUTING](../DOCS_CONTRIBUTING.md): Quy trinh dong gop va cap nhat tai lieu.
- [DOCS_STYLEGUIDE](../DOCS_STYLEGUIDE.md): Quy chuan viet tai lieu.
- [QUALITY_GATES](../QUALITY_GATES.md): Gate chat luong theo phase va theo scope.
- [TEMPLATE_INDEX](../TEMPLATE_INDEX.md): Danh muc template theo `doc_type`.

## 3) Skill & Workflow Surface

- Workflow: `.clinerules/workflows/document-management.md`
- Skills: `.cline/skills/*`
- Bootstrap hook: `.clinerules/hooks/TaskStart(.ps1)`

## 4) Template Library

Core templates (default):

- `docs/templates/feature-brief.template.md`
- `docs/templates/requirements.template.md`
- `docs/templates/hld.template.md`
- `docs/templates/dld.template.md`

Optional templates (on-demand):

- `docs/templates/api-spec.template.md`
- `docs/templates/ops-runbook.template.md`
- `docs/templates/security-model.template.md`
- `docs/templates/traceability.template.md`
- `docs/templates/release-readiness.template.md`
- `docs/templates/adr.template.md`

## 5) Releases

- [Changelog Index](./changelog/index.md)
- [Latest](./changelog/latest.md)

## 6) Quy tac van hanh nhanh

1. Chon mode trong workflow `document-management` (`new-feature` hoac `update-existing`).
2. Chay discovery truoc moi create/update.
3. New feature mac dinh: `feature-brief -> requirements -> hld -> dld`.
4. Chi bo sung API/Ops/Security/Traceability/Release-readiness/ADR khi co yeu cau ro rang hoac scope bat buoc.
5. Chay cac quality gate bat buoc theo scope truoc publish.
6. Voi update-existing theo reverse/backfill tu code hien huu, ap dung them gate consistency theo `QUALITY_GATES.md` (G8).
