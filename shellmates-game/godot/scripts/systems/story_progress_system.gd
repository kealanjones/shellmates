class_name StoryProgressSystem
extends RefCounted


func complete_active_path(app_state) -> bool:
	var role: String = str(app_state.active_role)
	if app_state.is_path_complete(role):
		return false

	var paths = app_state.story_state.get("paths_complete", {})
	if typeof(paths) != TYPE_DICTIONARY:
		paths = {}
	paths[role] = true
	app_state.story_state["paths_complete"] = paths

	var path_data: Dictionary = _get_path_data(app_state, role)
	var completion_signal: String = str(path_data.get("completion_signal", ""))
	var signals = app_state.story_state.get("completion_signals", [])
	if typeof(signals) != TYPE_ARRAY:
		signals = []
	if completion_signal != "" and not signals.has(completion_signal):
		signals.append(completion_signal)
	app_state.story_state["completion_signals"] = signals

	evaluate_tidegate(app_state)
	return true


func evaluate_tidegate(app_state) -> void:
	var tidegate = app_state.chapter.get("tidegate", {})
	if typeof(tidegate) != TYPE_DICTIONARY:
		tidegate = {}
	var required_signals = tidegate.get("required_signals", [])
	var signals = app_state.story_state.get("completion_signals", [])
	if typeof(required_signals) != TYPE_ARRAY or typeof(signals) != TYPE_ARRAY:
		app_state.story_state["tidegate_unlocked"] = false
		return

	var has_all_signals: bool = true
	for required_signal in required_signals:
		if not signals.has(required_signal):
			has_all_signals = false
			break

	app_state.story_state["tidegate_unlocked"] = has_all_signals
	if has_all_signals:
		app_state.story_state["reward_granted"] = true


func get_tidegate_status_text(app_state) -> String:
	var tidegate = app_state.chapter.get("tidegate", {})
	if typeof(tidegate) != TYPE_DICTIONARY:
		tidegate = {}
	if bool(app_state.story_state.get("reward_granted", false)):
		return str(tidegate.get("ready_text", "Our Tidegate opens."))

	var completed_count: int = app_state.get_completed_path_count()
	if completed_count == 1:
		return str(tidegate.get("half_lit_text", "The lantern is half-lit. The tide is gathering."))
	if completed_count >= 2:
		return str(tidegate.get("ready_text", "Both lobsters have brought their glow shells."))

	return str(tidegate.get("locked_text", "The Cove lantern is dim."))


func get_path_status_text(app_state, role: String) -> String:
	var path_data: Dictionary = _get_path_data(app_state, role)
	if app_state.is_path_complete(role):
		return str(path_data.get("complete_text", "Path complete."))
	return str(path_data.get("step_text", "A small path step is ready."))


func _get_path_data(app_state, role: String) -> Dictionary:
	var paths = app_state.chapter.get("paths", {})
	if typeof(paths) != TYPE_DICTIONARY:
		return {}
	var path_data = paths.get(role, {})
	return path_data if typeof(path_data) == TYPE_DICTIONARY else {}
