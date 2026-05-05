extends Control

const UI = preload("res://scripts/ui/ui_factory.gd")

var app_controller
var app_state


func setup(controller, state) -> void:
	app_controller = controller
	app_state = state


func _ready() -> void:
	var content: VBoxContainer = UI.prepare_screen_root(self)
	content.add_child(UI.make_title(str(app_state.chapter.get("title", "Story Chapter"))))
	content.add_child(UI.make_label(str(app_state.chapter.get("hook", "")), 18, HORIZONTAL_ALIGNMENT_CENTER))

	UI.add_card(content, "Current Local Role", "%s is taking a tiny solo step." % app_state.get_active_player_name())
	UI.add_card(content, "Player A Path", app_controller.get_story_path_status("A"))
	UI.add_card(content, "Player B Path", app_controller.get_story_path_status("B"))
	UI.add_card(content, "Our Tidegate", app_controller.get_tidegate_status_text())

	if bool(app_state.story_state.get("reward_granted", false)):
		_add_resolution(content)

	UI.add_small_gap(content)
	var complete_button: Button = UI.make_button("Complete %s path" % app_state.get_active_player_name(), Callable(app_controller, "complete_current_story_path"))
	if app_state.is_path_complete(app_state.active_role):
		complete_button.text = "%s path is complete" % app_state.get_active_player_name()
		complete_button.disabled = true
	content.add_child(complete_button)
	content.add_child(UI.make_button("Back to Cove", Callable(app_controller, "show_cove")))


func _add_resolution(content: VBoxContainer) -> void:
	var reward: Dictionary = app_state.chapter.get("reward", {})
	var body: String = "%s\nReward: %s" % [
		str(app_state.chapter.get("resolution_text", "The Cove glows softly again.")),
		str(reward.get("title", "Placeholder Keepsake"))
	]
	UI.add_card(content, "Shared Resolution", body)
