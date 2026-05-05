class_name AppState
extends RefCounted

const ROLE_A = "A"
const ROLE_B = "B"

var active_role: String = ROLE_A
var players: Array = []
var lobsters: Array = []
var mood_options: Array = []
var note_templates: Array = []
var chapter: Dictionary = {}
var moods: Dictionary = {}
var shell_notes: Array = []
var latest_note: Dictionary = {}
var story_state: Dictionary = {}
var note_counter: int = 0


func reset_with_content(content: Dictionary) -> void:
	active_role = ROLE_A
	players = content.get("players", []).duplicate(true)
	lobsters = content.get("lobsters", []).duplicate(true)
	mood_options = content.get("mood_options", []).duplicate(true)
	note_templates = content.get("note_templates", []).duplicate(true)
	chapter = content.get("chapter", {}).duplicate(true)
	moods = _default_moods()
	shell_notes = []
	latest_note = {}
	note_counter = 0
	story_state = _default_story_state()


func apply_save_dict(save_data: Dictionary) -> void:
	if save_data.is_empty():
		return

	active_role = _normalise_role(str(save_data.get("active_role", ROLE_A)))

	var saved_moods = save_data.get("moods", {})
	moods = _default_moods()
	if typeof(saved_moods) == TYPE_DICTIONARY:
		moods[ROLE_A] = str(saved_moods.get(ROLE_A, ""))
		moods[ROLE_B] = str(saved_moods.get(ROLE_B, ""))

	var saved_notes = save_data.get("shell_notes", [])
	shell_notes = saved_notes.duplicate(true) if typeof(saved_notes) == TYPE_ARRAY else []

	var saved_latest_note = save_data.get("latest_note", {})
	latest_note = saved_latest_note.duplicate(true) if typeof(saved_latest_note) == TYPE_DICTIONARY else {}

	note_counter = int(save_data.get("note_counter", shell_notes.size()))
	story_state = _merge_story_state(save_data.get("story_state", {}))


func to_save_dict() -> Dictionary:
	return {
		"save_version": 1,
		"active_role": active_role,
		"moods": moods.duplicate(true),
		"shell_notes": shell_notes.duplicate(true),
		"latest_note": latest_note.duplicate(true),
		"note_counter": note_counter,
		"story_state": story_state.duplicate(true)
	}


func switch_role() -> void:
	active_role = get_partner_role()


func get_partner_role() -> String:
	return ROLE_B if active_role == ROLE_A else ROLE_A


func get_player(role: String) -> Dictionary:
	for player in players:
		if str(player.get("role", "")) == role:
			return player
	return {
		"role": role,
		"display_name": "Player %s" % role,
		"subtitle": "Prototype player"
	}


func get_lobster(role: String) -> Dictionary:
	for lobster in lobsters:
		if str(lobster.get("owner_role", "")) == role:
			return lobster
	return {
		"owner_role": role,
		"display_name": "Lobster %s" % role,
		"subtitle": "Prototype companion"
	}


func get_active_player_name() -> String:
	return str(get_player(active_role).get("display_name", "Player %s" % active_role))


func get_partner_player_name() -> String:
	return str(get_player(get_partner_role()).get("display_name", "Player %s" % get_partner_role()))


func get_mood_label(role: String) -> String:
	var mood_id: String = str(moods.get(role, ""))
	if mood_id == "":
		return "Not set yet"

	for mood in mood_options:
		if str(mood.get("mood_id", "")) == mood_id:
			return str(mood.get("label", "Unknown"))

	return "Not set yet"


func get_latest_note_summary() -> String:
	if latest_note.is_empty():
		return "No Shell note yet. A lobster is keeping watch."

	var sender_name: String = str(get_player(str(latest_note.get("sender_role", ""))).get("display_name", "Someone"))
	var recipient_name: String = str(get_player(str(latest_note.get("recipient_role", ""))).get("display_name", "Someone"))
	var read_state: String = "read" if str(latest_note.get("read_state", "")) == "read" else "new"
	return "%s to %s: \"%s\" (%s)" % [
		sender_name,
		recipient_name,
		str(latest_note.get("text", "")),
		read_state
	]


func is_path_complete(role: String) -> bool:
	var paths = story_state.get("paths_complete", {})
	if typeof(paths) != TYPE_DICTIONARY:
		return false
	return bool(paths.get(role, false))


func get_completed_path_count() -> int:
	var count: int = 0
	if is_path_complete(ROLE_A):
		count += 1
	if is_path_complete(ROLE_B):
		count += 1
	return count


func get_story_status_summary() -> String:
	if bool(story_state.get("reward_granted", false)):
		return "Our Tidegate is open. Lighthouse Glow Keepsake is resting in the Cove."
	if bool(story_state.get("tidegate_unlocked", false)):
		return "Both lobsters have brought their glow shells. Our Tidegate opens."
	if get_completed_path_count() == 1:
		return "The lantern is half-lit. The tide is gathering."
	return "The Cove lantern is dim and ready for its first glow shell."


func _default_moods() -> Dictionary:
	var defaults: Dictionary = {}
	defaults[ROLE_A] = ""
	defaults[ROLE_B] = ""
	return defaults


func _default_story_state() -> Dictionary:
	var paths: Dictionary = {}
	paths[ROLE_A] = false
	paths[ROLE_B] = false
	return {
		"chapter_id": str(chapter.get("chapter_id", "")),
		"paths_complete": paths,
		"completion_signals": [],
		"tidegate_unlocked": false,
		"reward_granted": false
	}


func _merge_story_state(saved_story_state) -> Dictionary:
	var merged: Dictionary = _default_story_state()
	if typeof(saved_story_state) != TYPE_DICTIONARY:
		return merged

	var saved_paths = saved_story_state.get("paths_complete", {})
	if typeof(saved_paths) == TYPE_DICTIONARY:
		var paths: Dictionary = {}
		paths[ROLE_A] = bool(saved_paths.get(ROLE_A, false))
		paths[ROLE_B] = bool(saved_paths.get(ROLE_B, false))
		merged["paths_complete"] = paths

	var saved_signals = saved_story_state.get("completion_signals", [])
	if typeof(saved_signals) == TYPE_ARRAY:
		merged["completion_signals"] = saved_signals.duplicate(true)

	merged["tidegate_unlocked"] = bool(saved_story_state.get("tidegate_unlocked", false))
	merged["reward_granted"] = bool(saved_story_state.get("reward_granted", false))
	return merged


func _normalise_role(role: String) -> String:
	return ROLE_B if role == ROLE_B else ROLE_A
