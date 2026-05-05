extends Control

const UI = preload("res://scripts/ui/ui_factory.gd")

var app_controller
var app_state


func setup(controller, state) -> void:
	app_controller = controller
	app_state = state


func _ready() -> void:
	var content: VBoxContainer = UI.prepare_screen_root(self)
	content.add_child(UI.make_title("Choose a Cove Mood"))
	content.add_child(UI.make_label(
		"Pick a tiny, optional signal for %s. It can change any time." % app_state.get_active_player_name(),
		18,
		HORIZONTAL_ALIGNMENT_CENTER
	))

	UI.add_card(content, "Current Mood", app_state.get_mood_label(app_state.active_role))

	for mood in app_state.mood_options:
		_add_mood_option(content, mood)

	UI.add_small_gap(content)
	content.add_child(UI.make_button("Back to Cove", Callable(app_controller, "show_cove")))


func _add_mood_option(content: VBoxContainer, mood: Dictionary) -> void:
	var mood_id: String = str(mood.get("mood_id", ""))
	var label: String = str(mood.get("label", "Mood"))
	var body: String = str(mood.get("description", "A small Cove signal."))
	var card: VBoxContainer = UI.add_card(content, label, body)
	card.add_child(UI.make_button("Choose %s" % label, Callable(app_controller, "select_mood").bind(mood_id)))
