# QUALITY_GATES

Tài liệu này định nghĩa gate chất lượng cho pipeline tài liệu phát triển phần mềm.

## G0 - Discovery Gate (bắt buộc trước authoring)

Pass khi:

- Có keyword set phù hợp domain.
- Có bằng chứng từ codebase.
- Có bằng chứng từ Confluence keyword + semantic search.
- Có quyết định rõ `reuse/update/new`.

Fail nếu:

- Chưa đọc candidate pages liên quan.
- Tạo trang mới khi chưa loại trừ trùng lặp.

## G1 - Requirements Gate

Pass khi:

- Mỗi requirement có `REQ-ID`.
- FR có acceptance criteria rõ.
- NFR có ngưỡng đo cụ thể.
- Không còn placeholder/mâu thuẫn.

Fail nếu:

- Có câu mơ hồ không test được.
- Không rõ owner hoặc verification method.

## G2 - HLD Gate

Pass khi:

- Có boundary và component/container rõ.
- Có data flow và integration points.
- Có tradeoff và ADR linkage.
- Mapping về requirements rõ.

Fail nếu:

- HLD không trace về `REQ-ID`.
- Thiếu quyết định/rationale cho điểm kiến trúc quan trọng.

## G3 - DLD Gate

Pass khi:

- Có module decomposition.
- Có sequence/state/failure handling.
- Có timeout/retry/idempotency khi cần.
- Mapping tới HLD + requirements.

Fail nếu:

- Thiếu mô tả behavior trong lỗi/edge cases.
- Scope vượt requirements/HLD.

## G4 - API/Event Contract Gate

Pass khi:

- Schema request/response/event đầy đủ.
- Có error taxonomy.
- Có versioning + compatibility policy.
- Mọi endpoint/event map về `REQ-ID`.

Fail nếu:

- Contract thiếu owner/version.
- Breaking change không có migration plan.

## G5 - Ops/Security Gate

Pass khi:

- Có SLI/SLO + error budget action.
- Có runbook + escalation.
- Có threat model + security controls.
- Có release/rollback readiness.

Fail nếu:

- Chỉ có policy slogan, không có thao tác vận hành cụ thể.

## G6 - Traceability Gate

Pass khi:

- Có matrix `REQ-ID -> HLD -> DLD -> API/Event -> Ops/Security -> Test`.
- Không còn contradiction.
- Rủi ro mở được ghi nhận và chấp nhận rõ.

Fail nếu:

- Bất kỳ requirement nào thiếu downstream artifact.

## G7 - Publish Governance Gate

Pass khi:

- Metadata page đầy đủ (`doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`).
- Status transition hợp lệ (`draft -> in-review -> approved -> published`).
- Có reviewer assignment + due date.

Fail nếu:

- Publish khi chưa `GO-PUBLISH`.
- Thiếu metadata hoặc review task.

## G8 - Reverse-Engineering Consistency Gate (khi dựng doc từ code hiện hữu)

Áp dụng cho các luồng: `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`.

Pass khi:

- Có verification evidence độc lập giữa tài liệu sinh ra và code hiện trạng.
- `consistencyScore >= 70` cho mỗi artifact chính (requirements/HLD/DLD/API hoặc Design Doc đơn vị).
- Các discrepancy `critical` và `major` đã được xử lý hoặc có lý do chấp nhận rõ.
- Không vượt quá 2 vòng revise cho cùng một unit/artifact.

Fail nếu:

- `consistencyScore < 70` nhưng chưa revise theo kết quả verification.
- Còn discrepancy `critical` chưa xử lý.
- Đã vượt 2 vòng revise mà vẫn chưa đạt tiêu chí.

Mandatory human review nếu:

- `consistencyScore < 50` cho bất kỳ artifact/unit nào, hoặc
- Bị reject sau 2 revision cycles.
