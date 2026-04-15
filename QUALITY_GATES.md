# QUALITY_GATES

Tai lieu nay dinh nghia gate chat luong cho pipeline tai lieu phat trien phan mem.

## Mo hinh ap dung gate

- Luong mac dinh (core-4 docs) bat buoc: `G0 -> G1 -> G2 -> G3`.
- Gate mo rong theo scope:
  - `G4` khi co `api-spec`.
  - `G5` khi co `ops-runbook` hoac `security-model`.
  - `G6` khi co traceability/governance artifact rieng.
  - `G7` khi co publish/update Confluence.
  - `G8` cho reverse-engineering/backfill tu code hien huu.

## G0 - Discovery Gate (bat buoc truoc authoring)

Pass khi:

- Co keyword set phu hop domain.
- Co bang chung tu codebase.
- Co bang chung tu Confluence keyword + semantic search.
- Co quyet dinh ro `reuse/update/new`.

Fail neu:

- Chua doc candidate pages lien quan.
- Tao trang moi khi chua loai tru trung lap.

## G1 - Requirements Gate (bat buoc cho core flow)

Pass khi:

- Moi requirement co `REQ-ID`.
- FR co acceptance criteria ro.
- NFR co nguong do cu the.
- Khong con placeholder/mau thuan.

Fail neu:

- Co cau mo ho khong test duoc.
- Khong ro owner hoac verification method.

## G2 - HLD Gate (bat buoc cho core flow)

Pass khi:

- Co boundary va component/container ro.
- Co data flow va integration points.
- Co tradeoff va ADR linkage.
- Mapping ve requirements ro.

Fail neu:

- HLD khong trace ve `REQ-ID`.
- Thieu quyet dinh/rationale cho diem kien truc quan trong.

## G3 - DLD Gate (bat buoc cho core flow)

Pass khi:

- Co module decomposition.
- Co sequence/state/failure handling.
- Co timeout/retry/idempotency khi can.
- Mapping toi HLD + requirements.

Fail neu:

- Thieu mo ta behavior trong loi/edge cases.
- Scope vuot requirements/HLD.

## G4 - API/Event Contract Gate (chi khi `api-spec` nam trong scope)

Pass khi:

- Schema request/response/event day du.
- Co error taxonomy.
- Co versioning + compatibility policy.
- Moi endpoint/event map ve `REQ-ID`.

Fail neu:

- Contract thieu owner/version.
- Breaking change khong co migration plan.

## G5 - Ops/Security Gate (chi khi ops/security nam trong scope)

Pass khi:

- Co SLI/SLO + error budget action.
- Co runbook + escalation.
- Co threat model + security controls.
- Co release/rollback readiness cho pham vi van hanh.

Fail neu:

- Chi co policy slogan, khong co thao tac van hanh cu the.

## G6 - Traceability Gate (chi khi traceability/governance artifact duoc yeu cau)

Pass khi:

- Co matrix toi thieu `REQ-ID -> HLD -> DLD`.
- Neu co API/Event/Ops/Security/Test artifact trong scope thi matrix co link day du toi cac artifact do.
- Khong con contradiction.
- Rui ro mo duoc ghi nhan va chap nhan ro.

Fail neu:

- Requirement thieu artifact downstream bat buoc theo pham vi da chon.

## G7 - Publish Governance Gate (chi khi publish/update Confluence)

Pass khi:

- Metadata page day du (`doc_type`, `owner`, `status`, `version`, `review_date`, `traceability_ref`).
- Status transition hop le (`draft -> in-review -> approved -> published`).
- Co reviewer assignment + due date.
- Tat ca gate bat buoc cho pham vi hien tai da pass.

Fail neu:

- Publish khi gate bat buoc cho scope chua pass.
- Thieu metadata hoac review task.

## G8 - Reverse-Engineering Consistency Gate (khi dung doc tu code hien huu)

Ap dung cho cac luong: `backfill-doc-from-codebase`, `reverse-engineer-feature-docs`.

Pass khi:

- Co verification evidence doc-vs-code doc lap.
- `consistencyScore >= 70` cho moi artifact chinh trong scope (core-4, va optional artifact neu co).
- Cac discrepancy `critical` va `major` da duoc xu ly hoac co ly do chap nhan ro.
- Khong vuot qua 2 vong revise cho cung unit/artifact.

Fail neu:

- `consistencyScore < 70` nhung chua revise theo ket qua verification.
- Con discrepancy `critical` chua xu ly.
- Da vuot 2 vong revise ma van chua dat tieu chi.

Mandatory human review neu:

- `consistencyScore < 50` cho bat ky artifact/unit nao, hoac
- Bi reject sau 2 revision cycles.
