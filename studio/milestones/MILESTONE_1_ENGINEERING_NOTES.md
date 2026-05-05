# Milestone 1 Engineering Notes — Godot Prototype Foundation

## What Was Implemented
- Created the initial Godot 4.x project foundation for the Milestone 1
  local-only mobile prototype.
- Added a portrait-first main/root scene that starts on the Cove screen.
- Added simple screen navigation for Cove, Mood, Shell Note, and Story.
- Added local prototype role switching between Player A and Player B.
- Added placeholder players and lobster companions from a small prototype data
  file.
- Added local mood selection for the active prototype role.
- Added template-only local Shell notes.
- Added one tiny asynchronous story chapter, "The Lantern That Forgot".
- Added local story path completion for Player A and Player B.
- Added Our Tidegate logic that unlocks only after both local paths complete.
- Added simple local JSON save/load at `user://shellmates_prototype_save.json`.
- Added a reset prototype data action for local testing.

## Project Path
- Godot project root: `shellmates-game/godot`
- The Technical Bible did not specify a different game project path, so the
  requested path was used.
- Game implementation files were kept out of `studio/`.

## Main Scenes
- `shellmates-game/godot/scenes/app/Main.tscn`
  - Root scene and app shell.
- `shellmates-game/godot/scenes/screens/CoveScreen.tscn`
  - Portrait-first Cove homepage.
- `shellmates-game/godot/scenes/screens/MoodScreen.tscn`
  - Mood selection screen.
- `shellmates-game/godot/scenes/screens/ShellNoteScreen.tscn`
  - Template Shell note screen.
- `shellmates-game/godot/scenes/screens/StoryScreen.tscn`
  - Tiny local story chapter screen.

## Main Scripts
- `shellmates-game/godot/scripts/app/app_controller.gd`
  - Bootstraps content, save/load, systems, and navigation.
- `shellmates-game/godot/scripts/app/navigation_system.gd`
  - Simple screen switching.
- `shellmates-game/godot/scripts/data/content_repository.gd`
  - Loads prototype JSON content.
- `shellmates-game/godot/scripts/systems/app_state.gd`
  - Holds current role, players, lobsters, moods, notes, and story state.
- `shellmates-game/godot/scripts/systems/save_service.gd`
  - Local JSON save/load/reset only.
- `shellmates-game/godot/scripts/systems/mood_system.gd`
  - Stores mood for the active prototype role.
- `shellmates-game/godot/scripts/systems/shell_note_system.gd`
  - Creates local template notes and marks latest received note as read.
- `shellmates-game/godot/scripts/systems/story_progress_system.gd`
  - Tracks path completion, Tidegate unlock, and placeholder reward state.
- `shellmates-game/godot/scripts/ui/*.gd`
  - Minimal portrait-first screen controllers and UI factory.

## How To Open Or Run
1. Install or open Godot 4.x.
2. Open/import the project at `shellmates-game/godot/project.godot`.
3. Run the project. The configured main scene is
   `res://scenes/app/Main.tscn`.
4. If using the command line with Godot on PATH, run from the repository root:
   `godot4 --path shellmates-game/godot`

## What Is Still Placeholder
- Player identities and display names.
- Lobster names and appearance.
- Cove layout, decoration, animation, sound, and visual polish.
- Mood labels and mood copy.
- Shell note copy.
- Chapter hook, path text, Tidegate copy, resolution text, and reward copy.
- The Lighthouse Glow Keepsake reward.
- All UI styling and layout beyond readable prototype panels and buttons.

## Deliberately Not Implemented
- Backend services.
- Account pairing.
- Network calls.
- Cloud storage or sync.
- Analytics.
- Monetisation.
- Push notifications.
- Production art.
- Large content batches.
- Relationship scores, love percentages, compatibility ratings, punitive
  streaks, or guilt-based inactivity language.
- Free-text Shell notes or production personal-data handling.
- Encryption, moderation, or privacy architecture for user-generated content.

## Known Risks
- Godot runtime validation was not available in this environment, so scene-load
  and script-parse validation still need to be run in Godot 4.x.
- The local role switcher is useful for testing but must keep being labelled as
  prototype tooling so it is not mistaken for account pairing.
- Template-only Shell notes protect the current privacy boundary but do not yet
  validate future personal-note UX.
- The generated UI is functional and readable, but real phone checks are still
  needed for tap comfort, safe areas, and text scaling.
- The local save model is intentionally simple and may need revision once
  approved data/privacy architecture exists.

## Runtime Stabilisation Update
- Date: 2026-05-05
- Branch: `feature/milestone-1-prototype`
- Project run status: not run in this shell because `godot`, `godot4`, and a
  Godot app bundle were not available from the local command line or
  `/Applications`.

### Parser And Runtime Issues Fixed
- Replaced remaining dynamic JSON returns with explicit `Dictionary` casts in
  prototype content loading and local save loading.
- Removed typed `Dictionary` locals around `Dictionary.get()` results in story
  progress and story resolution code, then normalised those values with
  `typeof(...)` checks before use.
- Confirmed the main scene is configured as `res://scenes/app/Main.tscn`.
- Confirmed all `res://` script and scene paths referenced by project, scenes,
  and scripts resolve to existing files.
- Confirmed all GDScript files have valid `extends` declarations.
- Confirmed no `:=` inference declarations or malformed `var` declarations
  remain in GDScript.

### Files Changed In Stabilisation
- `shellmates-game/godot/scripts/data/content_repository.gd`
- `shellmates-game/godot/scripts/systems/save_service.gd`
- `shellmates-game/godot/scripts/systems/story_progress_system.gd`
- `shellmates-game/godot/scripts/ui/story_screen.gd`
- `studio/milestones/MILESTONE_1_ENGINEERING_NOTES.md`

### Remaining Known Risks
- A real Godot 4.x launch is still required to confirm there are no editor-only
  parser warnings, import warnings, or UI layout issues.
- Save/load needs an app restart smoke test inside Godot to verify the
  `user://shellmates_prototype_save.json` path behaves as expected on the
  target platform.
- The prototype is still functional placeholder UI, so mobile readability must
  be checked on a small portrait device before M1 QA signoff.

### Recommended Next QA Checks
1. Open `shellmates-game/godot/project.godot` in Godot 4.x.
2. Run the main scene and confirm the Cove loads first.
3. Switch between Player A and Player B.
4. Set a mood for each role and confirm the Cove updates.
5. Send a Shell note and confirm it appears on the Cove.
6. Complete Player A and Player B story paths in both orders.
7. Confirm Our Tidegate unlocks only after both paths complete.
8. Restart the project and confirm local save/load restores mood, note, story,
   and Tidegate state.

## Recommended Next Engineering Tasks
1. Open the project in Godot 4.x and resolve any parser/import warnings.
2. Run through the full manual flow on desktop and a portrait mobile target.
3. Verify local save/load by restarting the project after mood, note, and story
   progress changes.
4. Add a tiny Godot validation scene or script once the team's Godot test
   approach is chosen.
5. Review all visible copy against the Relationship Safety and Tone gates.
6. Keep any next work scoped to local prototype polish unless a decision log
   entry authorises backend, pairing, personal data, analytics, monetisation,
   notifications, production art, or content scale.
