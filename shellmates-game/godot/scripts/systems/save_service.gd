class_name SaveService
extends RefCounted

const SAVE_PATH = "user://shellmates_prototype_save.json"
const SAVE_FILE_NAME = "shellmates_prototype_save.json"


func load_state() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}

	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Could not open local prototype save.")
		return {}

	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Local prototype save was not a valid JSON object.")
		return {}

	return parsed


func save_state(app_state) -> bool:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Could not write local prototype save.")
		return false

	file.store_string(JSON.stringify(app_state.to_save_dict(), "\t"))
	return true


func reset_save() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return true

	var dir: DirAccess = DirAccess.open("user://")
	if dir == null:
		push_error("Could not open user save directory for reset.")
		return false

	return dir.remove(SAVE_FILE_NAME) == OK
