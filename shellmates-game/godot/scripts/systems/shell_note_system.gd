class_name ShellNoteSystem
extends RefCounted


func create_or_update_note(app_state, template_id: String) -> Dictionary:
	var template: Dictionary = _find_template(app_state, template_id)
	if template.is_empty():
		return {}

	app_state.note_counter += 1
	var note: Dictionary = {
		"note_id": "sn_%03d" % app_state.note_counter,
		"sender_role": app_state.active_role,
		"recipient_role": app_state.get_partner_role(),
		"template_id": template_id,
		"text": str(template.get("text", "")),
		"read_state": "new"
	}

	# Milestone 1 deliberately uses local template notes only.
	# Production personal-data handling, moderation, privacy policy, sync, and
	# encryption are deferred until explicitly approved.
	app_state.shell_notes.append(note.duplicate(true))
	app_state.latest_note = note.duplicate(true)
	return note


func mark_latest_note_read_for_active_role(app_state) -> void:
	if app_state.latest_note.is_empty():
		return
	if str(app_state.latest_note.get("recipient_role", "")) != app_state.active_role:
		return

	var note_id: String = str(app_state.latest_note.get("note_id", ""))
	app_state.latest_note["read_state"] = "read"
	for index in range(app_state.shell_notes.size()):
		var note = app_state.shell_notes[index]
		if str(note.get("note_id", "")) == note_id:
			note["read_state"] = "read"
			app_state.shell_notes[index] = note
			return


func _find_template(app_state, template_id: String) -> Dictionary:
	for template in app_state.note_templates:
		if str(template.get("template_id", "")) == template_id:
			return template
	return {}
