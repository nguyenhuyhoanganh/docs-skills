---
name: doc-api-spec-authoring
description: Use when detailed service contracts are required on demand, including API/event schemas, compatibility policy, and integration error semantics.
---

# API and Event Spec Authoring

## Overview

Define contract-first interfaces for synchronous and asynchronous integration.

<HARD-GATE>
If API/Event contract scope is in play, do not publish implementation plans without explicit contract documents.
</HARD-GATE>

## Template Reference (Required, Reference-Only)

- Consult `references/api-spec.template.md` before drafting or updating API/Event specs.
- Use the template as structure guidance only; adapt fields to real contract scope.
- Do not keep unresolved placeholders in final content.

## Required Artifacts

- OpenAPI spec for HTTP APIs (if applicable)
- AsyncAPI or event contract spec for messaging/event-driven flows
- Change compatibility policy

## Required Contract Details

- Endpoint/event identifier and owner
- Request/response or event payload schema
- Required/optional fields and validation rules
- Error model and error code taxonomy
- Idempotency and retry semantics
- AuthN/AuthZ requirements
- Rate limits and quota assumptions
- Versioning and deprecation policy

## Compatibility Rule

For each breaking change candidate, document:

- Why it is breaking
- Consumer impact
- Migration path
- Sunset timeline

## Traceability Rule

Every endpoint/event must map back to one or more `REQ-ID` entries.

## Confluence Behavior

- Upsert page with `doc_type=api-spec`
- Attach generated schema artifacts when available
