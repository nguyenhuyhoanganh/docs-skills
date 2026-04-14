# DOCS_STYLEGUIDE

Quy chuẩn viết tài liệu cho software engineering docs trong `doc-management`.

## 1) Mục tiêu viết

- Rõ ràng: người đọc biết phải làm gì, ở đâu, khi nào.
- Kiểm chứng được: requirement, metric, SLO có ngưỡng cụ thể.
- Vận hành được: không dừng ở lý thuyết, phải có hành động cụ thể.

## 2) Giọng văn và cấu trúc

- Viết trực tiếp, ngắn gọn, tránh khẩu hiệu.
- Mỗi section trả lời rõ: mục tiêu, phạm vi, quyết định, rủi ro, hành động.
- Ưu tiên danh sách/ bảng cho nội dung checklist/contract.

## 3) Quy tắc tránh mơ hồ

Không dùng các cụm không đo được nếu không có định lượng:

- "xử lý lỗi phù hợp"
- "đảm bảo bảo mật"
- "độ trễ thấp"
- "hệ thống ổn định"

Bắt buộc thay bằng dạng đo được:

- "p95 latency < 300ms ở 500 RPS"
- "retry tối đa 3 lần với exponential backoff 100/300/900ms"
- "MTTR mục tiêu <= 30 phút"

## 4) Chuẩn nội dung theo artifact

- Requirements: có `REQ-ID`, rationale, priority, acceptance criteria, verification method, owner.
- HLD: boundary, component map, data flow, tradeoff, ADR linkage.
- DLD: module behavior, state/sequence, failure/recovery, concurrency notes.
- API spec: schema, error model, idempotency, versioning, deprecation policy.
- Ops/Security: SLI/SLO, runbook, escalation, threat model, control mapping.

## 5) Diagram standard

- Mặc định PlantUML.
- Dùng C4-PlantUML cho context/container/component khi phù hợp.
- Mermaid chỉ fallback khi có constraint rõ và ghi lý do fallback.
- Mỗi diagram phải có title, scope, relation label.

## 6) Linking và traceability

- Mọi requirement phải link được tới HLD/DLD/API/Ops/Test.
- Mọi quyết định kiến trúc lớn phải có ADR reference.
- Mọi trang xuất bản phải có `traceability_ref`.

## 7) Nguyên tắc chống drift

- Không copy nguyên nội dung giữa nhiều trang; ưu tiên link đến source-of-truth.
- Khi update theo code change, cập nhật phần impacted trước, rồi sync matrix.
- Mọi thay đổi breaking phải có migration note.
