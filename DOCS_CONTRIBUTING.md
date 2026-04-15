# DOCS_CONTRIBUTING

Tai lieu nay quy dinh cach dong gop tai lieu cho `doc-management` theo chuan software development documentation.

## 1) Nguyen tac bat buoc

- Moi thay doi create/update doc phai chay `doc-context-discovery` truoc.
- Luong mac dinh cho feature moi chi gom 4 tai lieu: `feature-brief -> requirements -> hld -> dld`.
- Khong viet HLD/DLD khi requirements chua approved.
- `api-spec`, `ops-runbook`, `security-model`, `traceability`, `release-readiness`, `adr` chi tao khi co yeu cau ro hoac scope bat buoc.
- Khong publish neu chua qua cac quality gate bat buoc cho pham vi hien tai.
- Chi bat buoc `doc-traceability-and-gates` khi scope co traceability/governance artifact.
- Diagram kien truc/quy trinh uu tien PlantUML.
- Tai lieu publish phai co metadata: `doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref` (co the dung ref inline neu khong co trang traceability rieng).

## 2) Khi nao bat buoc cap nhat tai lieu

Bat buoc cap nhat docs neu PR co mot trong cac thay doi sau:

- Thay doi behavior user-facing.
- Thay doi API/Event contract.
- Thay doi kien truc (service boundary, data flow, dependency).
- Thay doi SLI/SLO/runbook/security control.
- Thay doi policy compatibility/versioning/deprecation.

## 3) Quy trinh dong gop chuan

1. Chon mode trong workflow duy nhat `document-management`:
   - `new-feature`
   - `update-existing`
2. Chay discovery de tim trang lien quan va quyet dinh update/reuse/new.
3. Soan core-4 docs theo template tuong ung trong `docs/templates/` (neu mode `new-feature`) hoac cap nhat dung section bi anh huong (neu mode `update-existing`).
4. Neu co yeu cau, bo sung cac tai lieu optional can thiet theo scope.
5. Chay quality gate theo `QUALITY_GATES.md` cho dung pham vi.
6. Neu pass va co yeu cau publish: publish/update va set metadata + reviewer task.

## 4) Checklist truoc khi mo PR docs

- [ ] Da chon dung mode trong workflow `document-management`.
- [ ] Da co evidence discovery (codebase + Confluence).
- [ ] Da dung dung template.
- [ ] Khong con `TBD`/`TODO` placeholder.
- [ ] Link noi bo con hop le.
- [ ] Diagram source (PlantUML/Mermaid fallback) co dinh kem.
- [ ] Da cap nhat traceability matrix neu scope co traceability/governance artifact.
- [ ] Metadata day du va nhat quan.

## 5) Quy tac review

Reviewer tap trung vao:

- Tinh dung/sat thuc te he thong.
- Tinh do duoc (dac biet FR/NFR/acceptance criteria/SLO).
- Tinh traceability tu `REQ-ID` den cac artifact nam trong pham vi tai lieu.
- Tinh van hanh duoc (runbook/escalation/rollback).

## 6) Quy tac dat ten va version

- Ten trang phai phan anh domain + artifact type + scope.
- Dung version monotonic hoac semver, nhung phai nhat quan theo `doc_type`.
- Neu breaking change o contract/architecture: bat buoc ghi migration path + sunset timeline.
