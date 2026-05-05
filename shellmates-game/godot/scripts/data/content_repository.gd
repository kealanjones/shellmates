class_name PrototypeContentRepository
extends RefCounted

const CONTENT_PATH = "res://data/prototype/prototype_content.json"

var content: Dictionary = {}


func load_content() -> Dictionary:
	var file: FileAccess = FileAccess.open(CONTENT_PATH, FileAccess.READ)
	if file == null:
		push_error("Could not open prototype content at %s" % CONTENT_PATH)
		content = {}
		return content

	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Prototype content is not a valid JSON object.")
		content = {}
		return content

	content = parsed as Dictionary
	return content
