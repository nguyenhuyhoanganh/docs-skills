# Benchmark: Provider and Diagram Standards

This document captures external standards used to shape this repository's documentation skills and workflows.

## Skills and Agent Workflow Standards

### Anthropic

- Agent Skills overview and architecture
  - https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
- Skill authoring best practices
  - https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
- Skills for enterprise governance
  - https://platform.claude.com/docs/en/agents-and-tools/agent-skills/enterprise
- Claude MCP integration guidance
  - https://code.claude.com/docs/en/mcp

Adopted patterns:

- progressive disclosure for skill content
- enterprise risk review and evaluation before deployment
- lifecycle management and coexistence testing

### OpenAI

- Practical guide to building AI agents
  - https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/
- Function calling best practices
  - https://developers.openai.com/api/docs/guides/function-calling#best-practices-for-defining-functions
- MCP trust and safety guidance
  - https://developers.openai.com/api/docs/mcp#connecting-to-trusted-servers

Adopted patterns:

- clear tool definitions with constrained schemas
- explicit orchestration and guardrails
- trust-boundary awareness for MCP servers

### Google Gemini

- Function calling and tool orchestration
  - https://ai.google.dev/gemini-api/docs/function-calling
- Structured output guidance
  - https://ai.google.dev/gemini-api/docs/structured-output
- Prompting strategies
  - https://ai.google.dev/gemini-api/docs/prompting-strategies

Adopted patterns:

- compositional tool calling
- structured output-first generation
- explicit function-calling modes and constraints

## Diagram Standards (PlantUML First)

### PlantUML (Primary)

- PlantUML docs
  - https://plantuml.com/
- PlantUML standard library
  - https://plantuml.com/stdlib
- C4-PlantUML repository
  - https://github.com/plantuml-stdlib/C4-PlantUML
- C4-PlantUML samples
  - https://plantuml-stdlib.github.io/C4-PlantUML/samples/C4CoreDiagrams.html

Reason selected as default:

- mature architecture-oriented ecosystem
- direct support for C4 model conventions
- strong fit for enterprise architecture artifacts

### Mermaid (Fallback)

- Mermaid syntax reference
  - https://mermaid.js.org/intro/syntax-reference
- Mermaid flowchart syntax
  - https://mermaid.js.org/syntax/flowchart.html
- Mermaid sequence syntax
  - https://mermaid.js.org/syntax/sequenceDiagram.html

Fallback usage:

- render/runtime constraints in target platform
- policy constraints against PlantUML execution paths

## Reliability and Operational Documentation Standards

- Google SRE workbook: implementing SLOs
  - https://sre.google/workbook/implementing-slos/
- Google SRE workbook: error budget policy
  - https://sre.google/workbook/error-budget-policy/

Adopted patterns:

- SLO with review cadence
- explicit error budget actions and escalation path

## Architecture Documentation Standards

- C4 model
  - https://c4model.com/
- arc42 overview
  - https://arc42.org/overview

Adopted patterns:

- multi-view architecture documentation
- explicit decision and rationale structure
