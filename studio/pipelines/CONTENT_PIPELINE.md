# Content Pipeline — Scalable and Safe

## Pipeline Stages
1. **Content request** (problem, player need, milestone fit).
2. **Schema check** (map to existing schema; propose updates if required).
3. **Small candidate batch** (limited sample only).
4. **Relationship safety review**.
5. **Narrative review**.
6. **Mobile UX review** (if interaction-facing).
7. **QA review** (duplication, tone drift, validation).
8. **Implementation handoff**.
9. **Regression check** after integration.
10. **Decision log update** when process/structure changes.

## Batch Size Rule
- Never generate hundreds of prompts, items, or chapters in one pass at this stage.
- Use small, reviewed batches with clear feedback loops.

## Quality Safeguards
- Reject duplicate, bland, or therapy-coded content.
- Enforce category/intensity metadata for prompts.
- Confirm magical-world framing and non-guilt language.

## Exit Condition
Content is “ready” only when schema-valid, safety-cleared, narrative-consistent, and QA-approved.
