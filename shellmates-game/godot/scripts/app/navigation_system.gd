class_name NavigationSystem
extends RefCounted

var _screen_host: Node
var _routes: Dictionary = {}
var _current_screen: Node


func configure(screen_host: Node, routes: Dictionary) -> void:
	_screen_host = screen_host
	_routes = routes


func show(route_name: String, controller: Node, app_state) -> void:
	if _screen_host == null:
		push_error("Navigation host has not been configured.")
		return
	if not _routes.has(route_name):
		push_error("Unknown prototype route: %s" % route_name)
		return

	if _current_screen != null and is_instance_valid(_current_screen):
		_current_screen.queue_free()

	var scene: PackedScene = load(str(_routes[route_name])) as PackedScene
	if scene == null:
		push_error("Could not load prototype screen: %s" % route_name)
		return

	var screen: Node = scene.instantiate()
	if screen.has_method("setup"):
		screen.call("setup", controller, app_state)
	_screen_host.add_child(screen)
	_current_screen = screen
