# Milestone 1 Implementation Plan — Local-Only Mobile Prototype

## Source Inputs
This plan follows:
- `AGENTS.md`
- `studio/bibles/GAME_BIBLE.md`
- `studio/bibles/MOBILE_BIBLE.md`
- `studio/bibles/TECHNICAL_BIBLE.md`
- `studio/bibles/RELATIONSHIP_DESIGN_BIBLE.md`
- `studio/schemas/CONTENT_SCHEMAS.md`
- `studio/reviews/QUALITY_GATES.md`
- `studio/milestones/MILESTONE_1_MOBILE_PROTOTYPE.md`
- `studio/decisions/DECISION_LOG.md`

## 1. Prototype Goal
Build a local-only, portrait-first mobile prototype that proves the smallest
Shellmates loop:

1. A player lands in the Cove and sees two placeholder partners with two
   placeholder lobster companions.
2. Either placeholder player can set a light mood, send a template Shell note,
   and complete their solo story path.
3. The story only reaches the shared resolution when both placeholder players
   have contributed to Our Tidegate.
4. The local state saves and reloads without networking.

The prototype validates connection through play, not therapy. It must feel like
two tiny adventurers tending a shared seaside place, even though both
placeholder roles are simulated locally on one device.

## 2. Screens

### Global Prototype Shell
- Portrait-first mobile frame with safe-area padding.
- Simple navigation between Cove, Mood, Shell Note, and Story.
- One clear primary action per screen where practical.
- A clearly labelled local-only player switcher for testing Player A and
  Player B. This is a prototype simulator, not account pairing.
- No login, account, network, notification, analytics, shop, or monetisation UI.

### Cove Screen
Purpose: the homepage hub and default landing screen.

Must show:
- Shared Cove title or location label using placeholder copy.
- Two placeholder player badges.
- Two placeholder lobster companion badges.
- Current active placeholder player.
- Latest mood trace for each placeholder player, if set.
- Latest Shell note trace, if one exists.
- Tiny chapter status summary: My Path, Their Path, Our Tidegate.
- Primary action that reflects current state, such as setting a mood, reading a
  note, or continuing the story.

Must avoid:
- Streaks, scores, relationship ratings, urgency timers, or guilt language.
- Any copy implying one partner is failing to show up.
- Production Cove art or final UI polish commitments.

### Mood Screen
Purpose: a light optional ritual, not a wellbeing assessment.

Must support:
- Four to six placeholder mood choices with non-clinical labels.
- One selected mood per placeholder player.
- Replacing a mood without penalty.
- Returning to the Cove with a warm confirmation.

Example placeholder labels:
- Breezy
- Sparkly
- Sleepy Tide
- Stormy Around The Edges

Copy rules:
- Mood text must be playful and magical.
- Do not diagnose, rank, score, or interpret the relationship.

### Shell Note Screen
Purpose: lightweight asynchronous expression through lobster-delivered notes.

Must support:
- Template-only note sending from the active placeholder player to the other
  placeholder player.
- A small list of approved placeholder templates.
- A local inbox/outbox view.
- Marking a received note as read.
- Returning to the Cove where the latest note trace is visible.

Template-only is required for Milestone 1. Free-text notes would introduce real
personal data storage questions and must be approved before implementation.

Example placeholder templates:
- "I left a tiny shell by the lantern."
- "Your lobster looked very important today."
- "The tide saved you a sparkle."

Must avoid:
- "Your partner is waiting" style pressure.
- Read receipts framed as accountability.
- Push notification hooks.

### Story Screen
Purpose: one tiny asynchronous chapter proving My Path, Their Path, and Our
Tidegate.

Must show:
- Shared story hook.
- My Path card for the active placeholder player.
- Their Path card for the other placeholder player.
- Our Tidegate status.
- Shared resolution after both path signals are complete.
- Keepsake/reward stub after shared resolution.

Prototype chapter structure:
1. Shared hook: a small Cove lantern has lost its glow.
2. Player A path: find a placeholder spark near the tidepool.
3. Player B path: polish a placeholder shell lens.
4. Our Tidegate: opens only when both signals exist.
5. Shared resolution: the Cove lantern glows again.
6. Reward stub: a placeholder Keepsake appears in the Cove state.

Tidegate copy should use magical state language, such as:
- "The lantern is half-lit; one more spark will open the way."
- "The tide is gathering."

It must not say:
- "Your partner has not finished."
- "You are waiting on them."
- "Complete this before time runs out."

## 3. User Flow
1. Player opens the prototype and either loads an existing local save or starts
   the default local save.
2. Cove appears in portrait with two placeholder players, two placeholder
   lobsters, and a clear next action.
3. Active role defaults to Player A.
4. Player A opens Mood, chooses a light mood, and returns to the Cove.
5. Player A opens Shell Note, sends one template note to Player B via lobster,
   and returns to the Cove.
6. Player A opens Story, reads the tiny chapter hook, and completes Player A's
   path.
7. Our Tidegate remains locked with neutral magical copy because only one
   required signal exists.
8. Tester uses the local-only player switcher to become Player B.
9. Player B sees the Cove with Player A's mood and note traces.
10. Player B reads the Shell note and optionally sets their own mood.
11. Player B opens Story and completes Player B's path.
12. Our Tidegate unlocks because both signals exist.
13. Player resolves the shared Tidegate and receives a placeholder Keepsake.
14. Returning to the Cove shows the chapter as resolved.
15. Player closes and restarts the prototype; local save/load restores moods,
   notes, path progress, Tidegate status, and Keepsake state.

## 4. Systems Breakdown

### Local Prototype Role Simulator
- Owns active role: Player A or Player B.
- Exists only to simulate asynchronous use on one device.
- Must be labelled as local prototype tooling.
- Must not create account, pairing, identity, or networking assumptions.

### Local Save/Load
- Saves prototype state locally.
- Loads state on launch.
- Supports reset during testing.
- Stores only placeholder and template state.
- Must not store real relationship history, free-text personal notes, contacts,
  account identifiers, or analytics identifiers.

### Placeholder Profile And Lobster State
- Provides two fixed placeholder player profiles.
- Provides two fixed placeholder lobster companions.
- Allows display only; no production customisation system in Milestone 1.

### Mood System
- Stores one current mood per placeholder player.
- Allows replacement without penalty.
- Feeds latest mood traces back to the Cove.
- Uses non-clinical labels only.

### Shell Note System
- Uses approved template keys only.
- Creates local note records with sender role, recipient role, template key, and
  read state.
- Surfaces latest note trace in the Cove.
- Does not support free text, images, attachments, notifications, or delivery
  status beyond local read/unread state.

### Story Chapter System
- Loads one placeholder chapter from data.
- Tracks path progress separately for Player A and Player B.
- Emits completion signals when each path is complete.
- Does not allow one player to complete the main shared outcome alone.

### Tidegate System
- Reads required signals from chapter data.
- Shows locked, ready, and resolved states.
- Unlocks only when both Player A and Player B signals are present.
- Uses neutral magical copy while incomplete.

### Reward And Keepsake Stub System
- Adds a placeholder Keepsake ID after shared resolution.
- May add simple resource stubs if needed for future UI, but should not build
  economy depth.
- Must not imply relationship value or partner performance.

### Navigation And UI State
- Keeps navigation simple and predictable.
- Returns users to the Cove after completed short actions.
- Preserves context during interruptions where practical.

## 5. Data Models
These are planning structures, not implementation code. Field names should stay
close to the content schemas so later data-driven work is straightforward.

### Prototype Save
- `save_version`
- `active_role`
- `players[]`
- `lobsters[]`
- `moods[]`
- `shell_notes[]`
- `chapter_state`
- `keepsakes[]`
- `resource_stubs`
- `ui_state`

### Player Profile
- `player_id`
- `role` as Player A or Player B
- `display_name_key`
- `avatar_placeholder_key`

### Lobster Companion
- `lobster_id`
- `owner_role`
- `display_name_key`
- `appearance_placeholder_key`

### Mood State
- `role`
- `mood_id`
- `label_key`
- `icon_placeholder_key`
- `last_changed_session_marker`

### Shell Note
- `note_id`
- `sender_role`
- `recipient_role`
- `template_key`
- `created_order`
- `read_state`

### Story Chapter Data
- `chapter_id`
- `title_key`
- `theme`
- `my_path_id`
- `their_path_id`
- `tidegate_id`
- `resolution_id`
- `reward_ids[]`
- `support_action_ids[]` as empty for Milestone 1 unless explicitly needed

### Path Progress
- `path_id`
- `owner_role`
- `step_ids[]`
- `completed_step_ids[]`
- `completion_signal`
- `completion_signal_set`

### Tidegate State
- `tidegate_id`
- `required_signals[]`
- `received_signals[]`
- `status` as locked, ready, or resolved
- `unlock_text_key`
- `fallback_hint_key`

### Reward And Keepsake Stub
- `reward_id`
- `type`
- `quantity_or_ref`
- `keepsake_id`
- `origin_chapter_id`
- `presentation_key`

## 6. Scene Structure — Godot-Ready
Recommended future structure once implementation is approved:

- `scenes/app/Main.tscn`
  - Launch root, loads save, owns current high-level app state.
- `scenes/app/PrototypeShell.tscn`
  - Portrait mobile shell, safe-area layout, navigation, player switcher.
- `scenes/cove/CoveScreen.tscn`
  - Cove homepage, player/lobster badges, traces, chapter summary, primary CTA.
- `scenes/mood/MoodScreen.tscn`
  - Mood choices and confirmation state.
- `scenes/notes/ShellNoteScreen.tscn`
  - Template note picker, inbox/outbox, read state.
- `scenes/story/StoryScreen.tscn`
  - Chapter hook, path cards, Tidegate status, resolution.
- `scenes/shared/PlayerBadge.tscn`
  - Reusable placeholder player display.
- `scenes/shared/LobsterBadge.tscn`
  - Reusable placeholder lobster display.
- `scenes/shared/StatusRow.tscn`
  - Reusable compact state row for mobile readability.
- `scenes/shared/PrimaryActionButton.tscn`
  - Reusable large tap target.

No production art scenes, account scenes, network scenes, shop scenes,
analytics scenes, notification scenes, or backend configuration scenes should be
created for Milestone 1.

## 7. Script Structure — High Level
Recommended future script ownership once implementation is approved:

- `scripts/app/app_controller.gd`
  - Bootstraps local save, owns active role, routes between screens.
- `scripts/app/navigation_state.gd`
  - Minimal current-screen state and return-to-Cove behaviour.
- `scripts/systems/save_service.gd`
  - Local save/load/reset only.
- `scripts/systems/content_repository.gd`
  - Loads placeholder chapter, mood, note, reward, and Keepsake data.
- `scripts/systems/profile_service.gd`
  - Provides fixed placeholder players and lobsters.
- `scripts/systems/mood_service.gd`
  - Sets and reads current mood per placeholder role.
- `scripts/systems/shell_note_service.gd`
  - Creates template notes, lists local inbox/outbox, marks notes read.
- `scripts/systems/story_progression_service.gd`
  - Tracks path steps, completion signals, chapter resolution.
- `scripts/systems/tidegate_service.gd`
  - Evaluates required signals and Tidegate state.
- `scripts/ui/cove_screen_controller.gd`
  - Binds Cove state to mobile UI.
- `scripts/ui/mood_screen_controller.gd`
  - Binds mood choices and confirmation.
- `scripts/ui/shell_note_screen_controller.gd`
  - Binds template note and read flows.
- `scripts/ui/story_screen_controller.gd`
  - Binds chapter progress and Tidegate resolution.

Do not create network clients, account managers, analytics services,
monetisation services, push notification handlers, or personal data storage
services.

## 8. Implementation Sequence
This is the recommended build order for a Godot engineer. It is not executed by
this planning task.

1. Reconfirm no decision-log blockers have changed, especially portrait-first,
   Godot/GDScript, no backend, and no account pairing.
2. Create the minimal Godot project foundation only when implementation is
   authorised.
3. Set up the portrait prototype shell, safe-area layout, and simple navigation.
4. Add fixed placeholder Player A, Player B, and two lobster companion data.
5. Add local save/load/reset with a default save.
6. Build the Cove screen with placeholder badges, traces, chapter summary, and
   primary action routing.
7. Build the mood system and Mood screen.
8. Build the template Shell note system and Shell Note screen.
9. Add one placeholder chapter data payload matching the approved schema shape.
10. Build story path progress for Player A and Player B.
11. Build Tidegate evaluation and locked/ready/resolved UI states.
12. Add shared resolution and placeholder Keepsake/reward stub.
13. Wire save/load through moods, notes, paths, Tidegate, and Keepsake state.
14. Pass mobile readability checks on small and large portrait devices.
15. Run quality-gate review against vision, couples-first, relationship safety,
   mobile usability, asynchronous clarity, story structure, technical
   constraints, privacy, and scale.

## 9. Acceptance Criteria

### Product And Vision
- The prototype is couples-first and asynchronous-first.
- The Cove is the default home and offers meaningful solo action.
- Main chapter resolution requires both placeholder players.
- No therapy, diagnosis, relationship score, compatibility percentage, or
  punitive streak framing appears anywhere.

### Mobile UX
- Portrait layout is readable on small and large phones.
- Primary tap targets are generous and reachable.
- Text remains concise and legible.
- UI does not rely on colour alone for progress state.
- Safe areas are respected.

### Core Experience
- Two placeholder players appear.
- Two placeholder lobsters appear.
- Each placeholder player can set a mood.
- Each placeholder player can send and receive template Shell notes.
- One tiny story chapter contains My Path, Their Path, Our Tidegate, shared
  resolution, and a placeholder Keepsake/reward stub.

### Technical
- All state is local-only.
- Save/load survives app restart.
- Tidegate state is deterministic.
- Completing one path alone never resolves the shared chapter.
- No networking, backend, account pairing, analytics, monetisation, or push
  notification code exists.
- No free-text personal relationship data is stored.

### Content And Art
- Copy is placeholder, small-batch, and tone-safe.
- Art is placeholder only.
- No production art direction is locked.
- No large content batch is introduced.

## 10. Testing Approach
Manual verification should cover:

- Fresh launch creates or loads a valid local save.
- Cove displays both placeholder players and both lobsters.
- Player switcher changes active local role without suggesting account pairing.
- Player A can set mood; mood appears in the Cove.
- Player B can set mood; both mood traces remain visible.
- Player A can send a template Shell note to Player B.
- Player B can read the Shell note.
- Player B can send a template Shell note to Player A.
- Player A path completion alone leaves Our Tidegate locked.
- Player B path completion alone leaves Our Tidegate locked if Player A is not
  complete.
- Completing both paths in either order makes Our Tidegate ready.
- Resolving Our Tidegate creates the shared resolution and Keepsake stub.
- Save/load restores moods, notes, path progress, Tidegate status, and Keepsake.
- Reset returns to the default local prototype state.
- Small-phone portrait layout has readable text and usable taps.
- Large-phone portrait layout does not stretch into awkward empty panels.
- Copy review finds no blame, shame, scoring, clinical, or urgency language.
- Repository review finds no network, backend, account, analytics,
  monetisation, push notification, or production asset additions.

## 11. Risks
- The local role switcher may be mistaken for real account pairing unless it is
  clearly labelled as prototype-only.
- Tidegate locked states may accidentally sound like blame if copy is too
  direct.
- Shell notes could drift into personal data capture if free text is added.
- Mood labels could drift towards clinical or diagnostic language.
- Placeholder art may hide mobile readability issues that production pixel art
  later exposes.
- Save/load may overfit to Milestone 1 and need rework when real data policy is
  approved.
- Scope may creep into customisation, economy, notifications, or account
  systems before the core loop is validated.
- A local-only prototype cannot fully validate real cross-device asynchronous
  latency, delivery expectations, or pairing UX.

## 12. What Must Remain Placeholder
- Player names and identities.
- Lobster names, visuals, and cosmetics.
- Cove art, decorations, layout dressing, and animation.
- Mood labels, icons, and ritual copy.
- Shell note templates.
- Chapter title, hook, path beats, Tidegate text, resolution text, and Keepsake.
- Rewards, resource quantities, and economy tuning.
- Sounds, music, haptics, visual effects, and transitions.
- Any customisation touchpoint beyond fixed placeholder display.
- Save data contents, which must remain prototype-only and non-personal.

## 13. Decisions That Must Be Asked Before Proceeding
Ask before changing or adding any of the following:

- Core vision or north star.
- Couples-first positioning.
- Relationship safety policy.
- Deeper prompt handling, Brave Shell behaviour, or emotional intensity rules.
- Backend provider, backend architecture, or any networking.
- Account pairing, identity, contacts, invites, or cross-device sync.
- Free-text notes, personal memory storage, or any real personal relationship
  data storage.
- Analytics, monetisation, shop, ads, subscriptions, or purchase flows.
- Push notifications or reminder systems.
- Platform strategy or orientation shift away from portrait-first mobile.
- Engine or scripting direction away from Godot and GDScript.
- Art direction, production asset creation, or final character/lobster/Cove
  visuals.
- Story canon, final chapter naming, long-term progression, seasons, or economy
  structure.
- Large content generation or content pipeline scale-up.
