# Mô tả hệ thống doc-management

## Phạm vi đã tổng hợp
- Nguồn: toàn bộ `C:\Users\Admin\Desktop\workspace\doc-management` (skills, workflows, governance, templates, hooks, changelog).
- Trọng tâm: catalog skill, catalog workflow, ma trận skill-workflow, và các lưu ý vận hành quan trọng.

## 1. Catalog chi tiết từng skill

| Skill | Làm gì | Khi nào gọi | Input tối thiểu | Output bắt buộc | Gate quan trọng |
|---|---|---|---|---|---|
| `using-doc-superpowers` | Bootstrap quy trình tài liệu theo chuẩn enterprise: discovery-first, route workflow đúng family, kiểm soát publish governance. | Ngay khi bắt đầu mọi yêu cầu create/update tài liệu trong repo này. | Yêu cầu người dùng (loại việc cần làm). | Quyết định routing workflow + thứ tự phase skill cần dùng. | Không được bỏ `doc-context-discovery`; không viết out-of-order; không publish khi chưa qua gate. |
| `doc-context-discovery` | Khám phá ngữ cảnh từ codebase + Confluence, chấm điểm relevance, quyết định reuse/update/new. | Bắt buộc trước mọi create/update. | User request/change summary + codebase + Confluence space. | Context Discovery Report: keyword set, evidence codebase, evidence Confluence, bảng relevance, quyết định reuse/update/new, missing context list. | HARD-GATE: chưa có discovery report thì không được authoring; nếu toàn low-confidence thì phải xin thêm pointer rồi chạy lại. |
| `doc-feature-intake` | Chuẩn hóa đầu bài feature thành feature brief rõ boundary/unknown/risk. | Sau discovery, trước requirements. | Discovery report + raw feature request. | Feature brief đầy đủ section: problem, objective, in/out scope, affected components, assumptions/constraints, risks/open questions, requirement themes. | Không viết requirements khi intake chưa xong; intake không được bắt đầu nếu thiếu discovery report. |
| `doc-requirements-authoring` | Chuyển feature brief thành requirements có thể kiểm chứng (FR/NFR, acceptance criteria, metric). | Sau intake, trước HLD/DLD. | Feature brief + discovery evidence. | Requirements spec có `REQ-ID`, priority, rationale, Given/When/Then, verification method, owner; FR/NFR/constraints/KPI/risk. | Không viết HLD/DLD khi requirements chưa complete/approved; FR phải có acceptance criteria; NFR phải đo được; không còn TBD/TODO/mâu thuẫn. |
| `doc-hld-authoring` | Viết thiết kế cấp hệ thống: boundary, component/container, data flow, tradeoff, ADR. | Khi requirements đã approved. | Approved requirements + kiến trúc baseline + dependency map. | HLD có mapping về `REQ-ID`, tradeoff (kể cả option reject), risk + mitigation direction, ADR link/create. | Không author HLD trên requirements chưa approved; mọi quyết định kiến trúc quan trọng phải có ADR reference. |
| `doc-dld-authoring` | Viết thiết kế chi tiết cấp module/flow/state/failure handling phục vụ implementation. | Sau HLD. | HLD + requirements đã có. | DLD gồm decomposition, internal contract, sequence/state, data/persistence, validation/error, retry/timeout/idempotency, concurrency, rollback/migration. | Không tự mở rộng scope ngoài requirements/HLD; mỗi section lớn phải map ít nhất 1 `REQ-ID` + 1 section HLD. |
| `doc-api-spec-authoring` | Đặc tả API/Event contract-first (OpenAPI/AsyncAPI), error semantics, version/compatibility policy. | Khi cần contract chi tiết cho tích hợp. | Requirements + thông tin interface từ HLD/DLD. | API/Event spec có schema, validation, error taxonomy, idempotency/retry, AuthN/AuthZ, rate limit, version/deprecation, breaking-change analysis. | Không publish implementation plan nếu thiếu contract; breaking change bắt buộc impact + migration path + sunset timeline; mọi endpoint/event phải map `REQ-ID`. |
| `doc-ops-reliability-security` | Viết tài liệu sẵn sàng production: SLI/SLO, runbook, incident playbook, threat model, controls, compliance. | Trước release-ready claim hoặc khi incident/ops/security impacted. | Feature/design context + yêu cầu vận hành/bảo mật. | Ops runbook và/hoặc security model có owner + review date + bước hành động cụ thể. | Không được claim release-ready nếu phase này chưa hoàn tất; cấm câu khẩu hiệu không actionable. |
| `doc-diagrams-as-code` | Tạo diagram-as-code cho kiến trúc/quy trình (context/container/component/sequence/deployment/dataflow). | Khi doc có phần kiến trúc/quy trình cần minh họa. | Section kiến trúc/quy trình cần vẽ + phạm vi hệ thống. | Diagram source canonical (ưu tiên PlantUML), artifact render (SVG/PNG) khi cần, mapping tới entity trong HLD/DLD. | Mermaid chỉ dùng khi có constraint render/runtime cụ thể và phải ghi rõ lý do fallback. |
| `doc-traceability-and-gates` | Kiểm tra độ đầy đủ và truy vết end-to-end trước publish. | Trước publish hoặc khi cần quyết định GO/NO-PUBLISH. | Bộ artifacts đã author (requirements/HLD/DLD/API/Ops/Security/Test refs). | Traceability matrix + gate checklist + quyết định `GO-PUBLISH` hoặc `NO-PUBLISH` + blocker list. | HARD-GATE: nếu `NO-PUBLISH` thì tuyệt đối không publish. |
| `doc-confluence-publishing` | Publish/update Confluence có kiểm soát metadata, hierarchy, review task, versioning. | Chỉ sau khi gate traceability pass. | Bộ tài liệu đã approved + metadata tối thiểu + traceability ref. | Trang Confluence upsert đúng parent, metadata đầy đủ, status transition đúng, review task có reviewer + due date, change summary/version. | Không publish nếu chưa qua traceability; cấm chuyển trực tiếp `draft -> published`; archive cần replacement + approval token. |
| `doc-lifecycle-management` | Duy trì tài liệu theo vòng đời: phát hiện stale, cập nhật, deprecate/archive có kiểm soát. | Khi update docs theo code change, refresh định kỳ, incident follow-up, hoặc dọn stale docs. | Trang tài liệu hiện có + review_date + tín hiệu thay đổi từ code/contracts/runbook. | Quyết định update/version/deprecate/archive + metadata/owner/review_date mới + ghi chú thay đổi. | Trước mọi update/archive phải chạy discovery/relevance check; không archive nếu thiếu successor ref + approval token + communication note. |

## 2. Catalog chi tiết từng workflow

| Workflow | Mục tiêu | Skill gọi (thứ tự) | Đầu ra chính | Khi kết thúc workflow |
|---|---|---|---|---|
| `workflow-router` | Chọn đúng workflow family cho yêu cầu tài liệu. | `using-doc-superpowers` -> `discover-context` -> workflow đích -> `traceability-check`/`publish-confluence` (khi cần). | Quyết định tuyến xử lý rõ ràng theo loại yêu cầu. | Khi đã route đúng family và xác định bước tiếp theo có/không publish. |
| `discover-context` | Thu thập evidence và quyết định reuse/update/new. | `doc-context-discovery`. | Context Discovery Report. | Khi có relevance scoring + quyết định xử lý + (nếu low confidence) đã xin pointer và rerun. |
| `intake-feature` | Chuẩn hóa feature request trước requirements. | `doc-context-discovery` -> `doc-feature-intake`. | Feature brief chuẩn hóa. | Khi objective/scope/unknown rõ đủ để chuyển sang requirements. |
| `write-requirements` | Tạo requirements testable, measurable. | `doc-requirements-authoring`. | Requirements doc (FR/NFR/constraints/acceptance criteria). | Khi requirements đạt gate chất lượng và sẵn sàng handoff cho HLD. |
| `write-hld` | Tạo kiến trúc cấp cao và rationale. | `doc-hld-authoring`. | HLD + ADR linkage/tradeoff. | Khi boundary, integration, tradeoff, requirement mapping đã rõ. |
| `write-dld` | Tạo thiết kế chi tiết cấp module/flow. | `doc-dld-authoring`. | DLD chi tiết có mapping HLD + requirements. | Khi behavior/state/failure/recovery được mô tả đủ cho implementation. |
| `write-api-spec` | Chuẩn hóa contract API/Event và compatibility policy. | `doc-api-spec-authoring`. | API/Event spec (schema + error model + versioning/deprecation). | Khi endpoint/event map đủ về `REQ-ID` và policy tương thích rõ. |
| `write-ops-and-security` | Hoàn thiện readiness vận hành và bảo mật. | `doc-ops-reliability-security`. | Ops runbook + security documentation. | Khi có SLI/SLO, runbook, escalation, controls, compliance impact rõ. |
| `diagram-docs` | Sinh diagram-as-code chuẩn để hỗ trợ tài liệu kiến trúc/quy trình. | `doc-diagrams-as-code`. | Bộ diagram source + artifact render. | Khi diagram đạt chuẩn label/scope/mapping và đã attach vào doc mục tiêu. |
| `traceability-check` | Chặn publish nếu thiếu truy vết/gate. | `doc-traceability-and-gates`. | Traceability matrix + GO/NO-PUBLISH. | Khi tất cả gate pass hoặc đã có danh sách blocker NO-PUBLISH rõ ràng. |
| `publish-confluence` | Publish/update tài liệu lên Confluence có governance đầy đủ. | `doc-confluence-publishing`. | Trang đã publish/upsert + metadata + review task + version log. | Khi status transition hợp lệ và có reviewer assignment + due date. |
| `update-existing-docs` | Cập nhật tài liệu hiện có theo lifecycle policy. | `doc-context-discovery` -> `doc-lifecycle-management`. | Bản cập nhật/in-place hoặc versioned/deprecate/archive decision. | Khi metadata/owner/review_date đã đồng bộ theo quyết định lifecycle. |
| `update-doc-from-code-change` | Đồng bộ docs theo thay đổi code/diff. | `doc-context-discovery` -> `doc-lifecycle-management` -> `doc-traceability-and-gates` (nếu contract/architecture đổi). | Delta update có version bump + change summary. | Khi các trang impacted đã cập nhật và gate liên quan đã chạy lại. |
| `periodic-doc-refresh` | Làm mới docs quá hạn review_date. | `doc-context-discovery` -> `doc-lifecycle-management`. | Danh sách trang được update/deprecate/archive + owner/review_date mới. | Khi vòng review định kỳ hoàn tất theo policy lifecycle. |
| `incident-driven-doc-update` | Cập nhật docs sau sự cố để giảm lặp lại lỗi. | `doc-context-discovery` -> `doc-ops-reliability-security` -> `doc-lifecycle-management`. | Runbook/escalation/reliability controls cập nhật + incident reference metadata. | Khi tài liệu impacted theo incident đã cập nhật và republish hợp lệ. |
| `create-doc-from-existing-assets` | Tổng hợp tài liệu mới từ codebase + Confluence assets có sẵn. | `doc-context-discovery` -> `[authoring skill phù hợp]` -> `doc-diagrams-as-code` (khi cần) -> `doc-traceability-and-gates`. | Tài liệu mục tiêu có source mapping rõ, tránh duplicate. | Khi synthesis hoàn tất và traceability gate pass trước publish. |
| `backfill-doc-from-codebase` | Dựng baseline docs cho hệ thống legacy/chưa có docs đầy đủ. | `doc-context-discovery` -> `[requirements/hld/dld/api/ops skill theo phạm vi]` -> `doc-diagrams-as-code` -> verify consistency với code. | Bộ docs baseline + giả định còn thiếu evidence được đánh dấu rõ. | Khi docs đã được đối chiếu với code và publish ở trạng thái `draft` kèm review task. |
| `reverse-engineer-feature-docs` | Reverse-engineer tài liệu feature từ implementation hiện hữu theo từng đơn vị. | `doc-context-discovery` -> `[phase authoring skills]` -> `doc-diagrams-as-code` -> `doc-traceability-and-gates` -> `publish-confluence` (nếu pass). | Bộ docs theo unit + kết quả verify/review vòng lặp + artifact traceability tổng hợp. | Khi từng unit đạt ngưỡng consistency hoặc đã escalate mandatory human review theo gate G8. |

## 3. Ma trận nhanh: workflow nào gọi skill nào

| Skill | Các workflow thường gọi |
|---|---|
| `using-doc-superpowers` | `workflow-router` (entrypoint), toàn bộ luồng create/update gián tiếp qua router. |
| `doc-context-discovery` | `discover-context`, `intake-feature`, `update-existing-docs`, `update-doc-from-code-change`, `periodic-doc-refresh`, `incident-driven-doc-update`, `create-doc-from-existing-assets`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`, `workflow-router` (step đầu). |
| `doc-feature-intake` | `intake-feature` (và full new-feature pipeline). |
| `doc-requirements-authoring` | `write-requirements`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`. |
| `doc-hld-authoring` | `write-hld`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`. |
| `doc-dld-authoring` | `write-dld`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`. |
| `doc-api-spec-authoring` | `write-api-spec`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`. |
| `doc-ops-reliability-security` | `write-ops-and-security`, `incident-driven-doc-update`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`. |
| `doc-diagrams-as-code` | `diagram-docs`, `create-doc-from-existing-assets`, `backfill-doc-from-codebase`, `reverse-engineer-feature-docs` (và các luồng có section kiến trúc/quy trình). |
| `doc-traceability-and-gates` | `traceability-check`, `create-doc-from-existing-assets`, `update-doc-from-code-change` (khi impact kiến trúc/contract), `reverse-engineer-feature-docs`, `workflow-router` (trước publish). |
| `doc-confluence-publishing` | `publish-confluence`, `reverse-engineer-feature-docs` (sau gate pass), `backfill-doc-from-codebase` (publish draft + review tasks). |
| `doc-lifecycle-management` | `update-existing-docs`, `update-doc-from-code-change`, `periodic-doc-refresh`, `incident-driven-doc-update`. |

## 4. Điểm hay và lưu ý quan trọng ở doc-management

- Điểm mạnh lớn nhất là kỷ luật `discovery-first`: mọi create/update đều bị chặn nếu chưa có evidence từ codebase + Confluence.
- Hệ thống gate rất rõ theo pha (`G0..G8`), đặc biệt có `G8` riêng cho reverse-engineering với ngưỡng `consistencyScore >= 70` và tối đa 2 vòng revise.
- Chuẩn metadata được áp xuyên suốt (kể cả template, publish, lifecycle): `doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`.
- Luồng trạng thái tài liệu được quản trị chặt (`draft -> in-review -> approved -> published -> deprecated -> archived`), giảm rủi ro publish tắt.
- PlantUML-first được chuẩn hóa rõ (kèm mẫu C4/Sequence); Mermaid chỉ fallback khi có constraint và phải ghi lý do.
- Repo ưu tiên `update-in-place` để chống duplicate/drift và yêu cầu map traceability từ `REQ-ID` đến downstream artifact.
- Có hook bootstrap (`.clinerules/hooks/TaskStart(.ps1)`) tự inject `using-doc-superpowers` vào context, giảm nguy cơ chạy sai quy trình.
- Template library khá đầy đủ cho SDLC docs (feature brief, requirements, HLD, DLD, API, ops, security, traceability, release readiness, ADR).
- Lưu ý quan trọng: `docs/index.md` và `docs/sidebar.json` đang tham chiếu slug/file `MO_TA_CHI_TIET_HE_THONG_TAI_LIEU_VI` nhưng file này hiện không tồn tại trong repo (link chết, nên bổ sung hoặc chỉnh lại index/sidebar).
- Lưu ý vận hành: kỹ năng publish giả định có MCP namespace `ConfluenceDocOps.*`; nếu môi trường không có connector này thì các workflow publish cần fallback chiến lược khác.
