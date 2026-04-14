# DOCS_CONTRIBUTING

Tài liệu này quy định cách đóng góp tài liệu cho `doc-management` theo chuẩn software development documentation.

## 1) Nguyên tắc bắt buộc

- Mọi thay đổi create/update doc phải chạy `doc-context-discovery` trước.
- Không viết HLD/DLD khi requirements chưa approved.
- Không publish nếu chưa qua `doc-traceability-and-gates`.
- Diagram kiến trúc/quy trình ưu tiên PlantUML.
- Tài liệu publish phải có metadata: `doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`.

## 2) Khi nào bắt buộc cập nhật tài liệu

Bắt buộc cập nhật docs nếu PR có một trong các thay đổi sau:

- Thay đổi behavior user-facing.
- Thay đổi API/Event contract.
- Thay đổi kiến trúc (service boundary, data flow, dependency).
- Thay đổi SLI/SLO/runbook/security control.
- Thay đổi policy compatibility/versioning/deprecation.

## 3) Quy trình đóng góp chuẩn

1. Xác định workflow family phù hợp (`workflow-router`).
2. Chạy discovery để tìm trang liên quan và quyết định update/reuse/new.
3. Soạn tài liệu theo template tương ứng trong `docs/templates/`.
4. Chạy quality gate theo `QUALITY_GATES.md`.
5. Nếu pass: publish/update và set metadata + reviewer task.

## 4) Checklist trước khi mở PR docs

- [ ] Đã chọn đúng workflow.
- [ ] Đã có evidence discovery (codebase + Confluence).
- [ ] Đã dùng đúng template.
- [ ] Không còn `TBD`/`TODO` placeholder.
- [ ] Link nội bộ còn hợp lệ.
- [ ] Diagram source (PlantUML/Mermaid fallback) có đính kèm.
- [ ] Đã cập nhật traceability matrix nếu có requirement mới/đổi.
- [ ] Metadata đầy đủ và nhất quán.

## 5) Quy tắc review

Reviewer tập trung vào:

- Tính đúng/sát thực tế hệ thống.
- Tính đo được (đặc biệt FR/NFR/acceptance criteria/SLO).
- Tính traceability từ `REQ-ID` đến artifact downstream.
- Tính vận hành được (runbook/escalation/rollback).

## 6) Quy tắc đặt tên và version

- Tên trang phải phản ánh domain + artifact type + scope.
- Dùng version monotonic hoặc semver, nhưng phải nhất quán theo `doc_type`.
- Nếu breaking change ở contract/architecture: bắt buộc ghi migration path + sunset timeline.
