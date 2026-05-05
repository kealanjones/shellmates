extends Control

const UI = preload("res://scripts/ui/ui_factory.gd")

var app_controller
var app_state


func setup(controller, state) -> void:
	app_controller = controller
	app_state = state


func _ready() -> void:
	var content: VBoxContainer = UI.prepare_screen_root(self)
	content.add_child(UI.make_title("Send a Shell Note"))
	content.add_child(UI.make_label(
		"Choose a warm local template for %s's lobster to carry. Template notes stay on this device in Milestone 1." % app_state.get_active_player_name(),
		18,
		HORIZONTAL_ALIGNMENT_CENTER
	))

	UI.add_card(content, "Latest Note", app_state.get_latest_note_summary())

	for template in app_state.note_templates:
		_add_note_template(content, template)

	UI.add_small_gap(content)
	content.add_child(UI.make_button("Back to Cove", Callable(app_controller, "show_cove")))


func _add_note_template(content: VBoxContainer, template: Dictionary) -> void:
	var template_id: String = str(template.get("template_id", ""))
	var text: String = str(template.get("text", "A tiny shell note."))
	var card: VBoxContainer = UI.add_card(content, "Shell Note Template", "\"%s\"" % text)
	card.add_child(UI.make_button("Send or update latest note", Callable(app_controller, "send_shell_note").bind(template_id)))
