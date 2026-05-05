extends Control

const AppStateScript = preload("res://scripts/systems/app_state.gd")
const ContentRepositoryScript = preload("res://scripts/data/content_repository.gd")
const MoodSystemScript = preload("res://scripts/systems/mood_system.gd")
const NavigationSystemScript = preload("res://scripts/app/navigation_system.gd")
const SaveServiceScript = preload("res://scripts/systems/save_service.gd")
const ShellNoteSystemScript = preload("res://scripts/systems/shell_note_system.gd")
const StoryProgressSystemScript = preload("res://scripts/systems/story_progress_system.gd")

var app_state
var content_repository
var mood_system
var navigation_system
var save_service
var shell_note_system
var story_progress_system
var screen_host: Control


func _ready() -> void:
	_build_mobile_shell()
	_bootstrap_systems()
	show_cove()


func show_cove() -> void:
	navigation_system.show("cove", self, app_state)


func show_mood() -> void:
	navigation_system.show("mood", self, app_state)


func show_shell_note() -> void:
	shell_note_system.mark_latest_note_read_for_active_role(app_state)
	_save()
	navigation_system.show("shell_note", self, app_state)


func show_story() -> void:
	navigation_system.show("story", self, app_state)


func switch_local_role() -> void:
	app_state.switch_role()
	_save()
	show_cove()


func select_mood(mood_id: String) -> void:
	if mood_system.set_mood(app_state, mood_id):
		_save()
	show_cove()


func send_shell_note(template_id: String) -> void:
	shell_note_system.create_or_update_note(app_state, template_id)
	_save()
	show_cove()


func complete_current_story_path() -> void:
	story_progress_system.complete_active_path(app_state)
	_save()
	show_story()


func reset_prototype_data() -> void:
	save_service.reset_save()
	app_state.reset_with_content(content_repository.content)
	_save()
	show_cove()


func get_story_path_status(role: String) -> String:
	return story_progress_system.get_path_status_text(app_state, role)


func get_tidegate_status_text() -> String:
	return story_progress_system.get_tidegate_status_text(app_state)


func _bootstrap_systems() -> void:
	content_repository = ContentRepositoryScript.new()
	mood_system = MoodSystemScript.new()
	navigation_system = NavigationSystemScript.new()
	save_service = SaveServiceScript.new()
	shell_note_system = ShellNoteSystemScript.new()
	story_progress_system = StoryProgressSystemScript.new()

	var content: Dictionary = content_repository.load_content()
	app_state = AppStateScript.new()
	app_state.reset_with_content(content)
	app_state.apply_save_dict(save_service.load_state())
	story_progress_system.evaluate_tidegate(app_state)

	navigation_system.configure(screen_host, {
		"cove": "res://scenes/screens/CoveScreen.tscn",
		"mood": "res://scenes/screens/MoodScreen.tscn",
		"shell_note": "res://scenes/screens/ShellNoteScreen.tscn",
		"story": "res://scenes/screens/StoryScreen.tscn"
	})


func _build_mobile_shell() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

	var background: ColorRect = ColorRect.new()
	background.name = "WarmSeaBackground"
	background.color = Color8(239, 248, 243)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var margin: MarginContainer = MarginContainer.new()
	margin.name = "SafeAreaMargin"
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_top", 18)
	margin.add_theme_constant_override("margin_bottom", 18)
	add_child(margin)

	screen_host = Control.new()
	screen_host.name = "ScreenHost"
	screen_host.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	screen_host.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin.add_child(screen_host)


func _save() -> void:
	save_service.save_state(app_state)
