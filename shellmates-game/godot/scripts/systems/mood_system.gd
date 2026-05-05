class_name MoodSystem
extends RefCounted


func set_mood(app_state, mood_id: String) -> bool:
	if not _is_known_mood(app_state, mood_id):
		return false

	app_state.moods[app_state.active_role] = mood_id
	return true


func _is_known_mood(app_state, mood_id: String) -> bool:
	for mood in app_state.mood_options:
		if str(mood.get("mood_id", "")) == mood_id:
			return true
	return false
