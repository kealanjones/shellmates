class_name ShellmatesUIFactory
extends RefCounted


static func prepare_screen_root(screen: Control) -> VBoxContainer:
	screen.set_anchors_preset(Control.PRESET_FULL_RECT)

	var scroll: ScrollContainer = ScrollContainer.new()
	scroll.set_anchors_preset(Control.PRESET_FULL_RECT)
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	screen.add_child(scroll)

	var margin: MarginContainer = MarginContainer.new()
	margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin.add_theme_constant_override("margin_left", 4)
	margin.add_theme_constant_override("margin_right", 4)
	margin.add_theme_constant_override("margin_top", 4)
	margin.add_theme_constant_override("margin_bottom", 12)
	scroll.add_child(margin)

	var content: VBoxContainer = VBoxContainer.new()
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content.add_theme_constant_override("separation", 12)
	margin.add_child(content)
	return content


static func make_label(text: String, font_size: int = 18, alignment: int = HORIZONTAL_ALIGNMENT_LEFT) -> Label:
	var label: Label = Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.horizontal_alignment = alignment
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", Color8(48, 68, 66))
	return label


static func make_title(text: String) -> Label:
	return make_label(text, 30, HORIZONTAL_ALIGNMENT_CENTER)


static func make_section_title(text: String) -> Label:
	return make_label(text, 22, HORIZONTAL_ALIGNMENT_LEFT)


static func make_button(text: String, pressed_callback: Callable) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(0, 56)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 18)
	if pressed_callback.is_valid():
		button.pressed.connect(pressed_callback)
	return button


static func add_card(parent: VBoxContainer, title: String, body: String = "") -> VBoxContainer:
	var panel: PanelContainer = PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _panel_style())
	parent.add_child(panel)

	var margin: MarginContainer = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 14)
	margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(margin)

	var box: VBoxContainer = VBoxContainer.new()
	box.add_theme_constant_override("separation", 8)
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin.add_child(box)

	if title != "":
		box.add_child(make_section_title(title))
	if body != "":
		box.add_child(make_label(body, 17))
	return box


static func add_small_gap(parent: VBoxContainer) -> void:
	var gap: Control = Control.new()
	gap.custom_minimum_size = Vector2(0, 4)
	parent.add_child(gap)


static func _panel_style() -> StyleBoxFlat:
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color8(255, 249, 238)
	style.border_color = Color8(112, 151, 143)
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	return style
