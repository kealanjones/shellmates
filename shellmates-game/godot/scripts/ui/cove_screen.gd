extends Control

const UI = preload("res://scripts/ui/ui_factory.gd")

var app_controller
var app_state


func setup(controller, state) -> void:
	app_controller = controller
	app_state = state


func _ready() -> void:
	var content: VBoxContainer = UI.prepare_screen_root(self)
	content.add_child(UI.make_title("Shellmates Prototype"))
	content.add_child(UI.make_label("The Cove - local mobile loop test", 18, HORIZONTAL_ALIGNMENT_CENTER))

	UI.add_card(
		content,
		"Local Prototype Role",
		"You are guiding %s on this device. This switcher is prototype tooling, not account pairing." % app_state.get_active_player_name()
	)

	_add_pair_cards(content)
	_add_lobster_cards(content)
	UI.add_card(content, "Mood Traces", _mood_summary())
	UI.add_card(content, "Latest Shell Note", app_state.get_latest_note_summary())
	UI.add_card(content, str(app_state.chapter.get("title", "Story Chapter")), app_state.get_story_status_summary())

	UI.add_small_gap(content)
	content.add_child(UI.make_button("Set mood", Callable(app_controller, "show_mood")))
	content.add_child(UI.make_button("Write Shell note", Callable(app_controller, "show_shell_note")))
	content.add_child(UI.make_button("Open story chapter", Callable(app_controller, "show_story")))
	content.add_child(UI.make_button("Switch local prototype role to %s" % app_state.get_partner_player_name(), Callable(app_controller, "switch_local_role")))
	content.add_child(UI.make_button("Reset local prototype data", Callable(app_controller, "reset_prototype_data")))


func _add_pair_cards(content: VBoxContainer) -> void:
	var player_a: Dictionary = app_state.get_player("A")
	var player_b: Dictionary = app_state.get_player("B")
	UI.add_card(content, str(player_a.get("display_name", "Player A")), str(player_a.get("subtitle", "Prototype player")))
	UI.add_card(content, str(player_b.get("display_name", "Player B")), str(player_b.get("subtitle", "Prototype player")))


func _add_lobster_cards(content: VBoxContainer) -> void:
	var lobster_a: Dictionary = app_state.get_lobster("A")
	var lobster_b: Dictionary = app_state.get_lobster("B")
	UI.add_card(content, str(lobster_a.get("display_name", "Lobster A")), str(lobster_a.get("subtitle", "Prototype lobster")))
	UI.add_card(content, str(lobster_b.get("display_name", "Lobster B")), str(lobster_b.get("subtitle", "Prototype lobster")))


func _mood_summary() -> String:
	return "Player A: %s\nPlayer B: %s" % [
		app_state.get_mood_label("A"),
		app_state.get_mood_label("B")
	]
