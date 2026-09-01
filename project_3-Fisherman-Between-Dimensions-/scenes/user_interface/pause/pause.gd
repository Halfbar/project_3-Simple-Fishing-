extends Control

@onready var other_panels: Control = $other_panels
@onready var settings: Control = $other_panels/settings

@onready var btn_panel: Control = $btn_panel

const MAIN_MENU = "res://scenes/main_menu/main_menu.tscn"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused
		mouse_filter = Control.MOUSE_FILTER_STOP


func _on_btn_continue_pressed() -> void:
	get_tree().paused = false
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_btn_settings_pressed() -> void:
	settings.visible = true
	settings.mouse_filter = Control.MOUSE_FILTER_STOP
	btn_panel.visible = false
	btn_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_settings_exit_btn_pressed() -> void:
	close_panels()

func close_panels():
	var childs = other_panels.get_children()
	for child in childs:
		child.visible = false
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
	btn_panel.visible = true
	btn_panel.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_btn_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)
