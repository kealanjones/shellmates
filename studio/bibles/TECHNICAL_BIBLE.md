# Technical Bible — Shellmates

## Current Assumptions
- Engine assumption: Godot.
- Scripting assumption: GDScript-first.
- Architecture focus: mobile-first, data-driven, local prototype first.

## Core Technical Principles
- Separate scenes, scripts, and data.
- Keep chapter/prompt/item content data-driven.
- Favour reversible architecture early.
- Build for asynchronous shared-state clarity from the outset.

## Proposed Project Structure (Future)
- `scenes/` for UI and gameplay scenes.
- `scripts/` for logic modules.
- `data/` for schema-backed content payloads.
- `systems/` for save/load and progression orchestration.

## Prototype Data/State Rules
- Local save/load first.
- Two placeholder player profiles for prototype only.
- Shared progression represented locally for Milestone 1 validation.

## Deferred Systems (Do Not Implement Yet)
- Backend services and provider choice.
- Account pairing and identity linking.
- Personal relationship data storage architecture.
- Analytics events pipeline.
- Monetisation systems.
- Push notification implementation.

## Testing and Validation Principles
- Validate deterministic progression transitions.
- Validate asynchronous gate behaviour for out-of-order actions.
- Validate save/load integrity across app restarts.
- Validate mobile performance and memory use on representative phones.

## Mobile Performance Principles
- Stable frame pacing on mid-range devices.
- Memory budget awareness for pixel scenes and UI overlays.
- Avoid excessive background processing.

## PR and Branch Expectations
- Small, focused PRs tied to milestone outcomes.
- Include impact on quality gates and decision log when applicable.
- Document assumptions and deferred technical choices explicitly.
