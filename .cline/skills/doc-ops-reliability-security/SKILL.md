---
name: doc-ops-reliability-security
description: Use when feature documentation must include production readiness across reliability, operations, security, and compliance.
---

# Ops, Reliability, and Security Documentation

## Overview

Create deployment-grade operational and security documentation.

<HARD-GATE>
No release-ready claim without this phase complete.
</HARD-GATE>

## Template Reference (Required, Reference-Only)

- Consult `references/ops-runbook.template.md` and `references/security-model.template.md` before drafting or updating ops/security docs.
- Use templates as structure guidance only; adapt to actual operational/security scope.
- Do not keep unresolved placeholders in final content.

## Required Reliability Sections

- SLI definitions
- SLO targets and rationale
- Error budget policy and actions
- Capacity assumptions and scaling triggers
- Observability plan (logs, metrics, traces, dashboards)

## Required Operations Sections

- Runbook for routine operations
- Incident playbook with escalation path
- Rollout/canary/rollback strategy
- On-call ownership and handoff notes

## Required Security Sections

- Threat model summary
- Security controls by layer
- IAM and permission boundaries
- Secrets handling and key rotation notes
- Audit logging requirements
- Compliance impact statement

## Quality Rule

Operational and security sections must include actionable steps, not policy slogans.

Invalid examples:
- "Monitor system health"
- "Use secure authentication"

Valid examples must specify exact signal, threshold, and response.

## Confluence Behavior

- Upsert pages with `doc_type=ops-runbook` and/or `doc_type=security-model`
- Ensure explicit owner and review date metadata
