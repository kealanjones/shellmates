# Milestone 1 — Mobile Prototype

## Goal
Validate the core local asynchronous couple loop in a minimal mobile prototype:
two placeholder partners, two placeholder lobster companions, a Cove hub,
light mood setting, template Shell notes, and one tiny asynchronous chapter
with My Path, Their Path, and Our Tidegate logic.

## Implementation Plan
- Detailed plan: `studio/milestones/MILESTONE_1_IMPLEMENTATION_PLAN.md`.
- This milestone plan is Godot-ready planning only. It does not authorise
  backend, account pairing, analytics, monetisation, push notifications, a
  content scale-up, production assets, or storage of real personal
  relationship data.

## Prototype Scope
- Godot project foundation when prototype implementation is explicitly started.
- Portrait-first basic Cove screen.
- Two placeholder player profiles.
- Two placeholder lobsters.
- Mood setting interaction.
- Template-only Shell note flow.
- One tiny local asynchronous story chapter with My Path, Their Path, Our Tidegate.
- Local-only save/load.
- Simple data models for local state and schema-backed placeholder content.
- Placeholder art and placeholder copy only.

## Screens (Minimum)
- Cove/home screen.
- Mood setting screen.
- Shell note screen.
- Story chapter screen.
- Local prototype player-switch/debug control, clearly labelled as a local
  simulation tool and not account pairing.

## Systems (Minimum)
- Local progression state.
- Local save/load.
- Local placeholder profile and lobster state.
- Mood state.
- Template Shell notes.
- Dual-path chapter steps.
- Tidegate completion logic.
- Basic reward and memory stub handling.
- Simple navigation state.

## Out of Scope
- Backend.
- Account pairing.
- Analytics.
- Monetisation.
- Push notifications.
- Networking.
- Free-text personal relationship data storage.
- Production art, final character art, final lobster art, final Cove art, or
  final story canon.
- Large content batches.

## Acceptance Criteria
- Core loop is playable end-to-end locally on one device.
- The Cove always offers at least one meaningful non-punitive action.
- Both placeholder profiles and both placeholder lobsters are visible in the
  experience.
- Mood and Shell note interactions are light, optional, and tone-safe.
- Main story gate requires both placeholder profiles without blame language.
- My Path, Their Path, Our Tidegate, and a shared resolution are represented.
- UI is readable, touch-friendly, and usable in portrait on test devices.
- Save/load survives restart.
- No networking, backend, account pairing, analytics, monetisation, or push
  notification code exists in the prototype.
- No production art or large content batch is introduced.

## Risks
- Async state logic confusion.
- Mobile readability issues with placeholder art/UI.
- Scope creep into deferred systems.
- Template Shell notes accidentally drifting into real personal data capture.
- Debug player switching being mistaken for real account pairing.
- Tidegate copy accidentally implying blame for the inactive placeholder partner.

## Test/Check Approach
- Functional walkthroughs for all core flows.
- Save/load restart checks.
- Device checks on representative phones.
- QA mapping against quality gates.
- Confirm no network-facing or backend-adjacent systems have been added.
