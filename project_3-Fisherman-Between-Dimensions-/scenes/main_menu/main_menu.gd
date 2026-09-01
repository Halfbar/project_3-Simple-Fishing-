extends Control

@onready var panels: Control = $panels
@onready var settings: Control = $panels/settings

@onready var btn_panel: Control = $btn_panel

@export var mm_bg_music: AudioStream

const GAME_SCENE = "res://scenes/game_scene/game_scene.tscn"

func _ready() -> void:
	close_panels()
	SoundManager.stop_sounds()
	SoundManager.play_music(mm_bg_music)

func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)
	pass


func _on_btn_settings_pressed() -> void:
	settings.visible = true
	settings.mouse_filter = Control.MOUSE_FILTER_STOP
	btn_panel.visible = false
	btn_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_btn_exit_pressed() -> void:
	get_tree().quit()

func close_panels():
	var childs = panels.get_children()
	for child in childs:
		child.visible = false
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
	btn_panel.visible = true
	btn_panel.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_settings_exit_btn_pressed() -> void:
	close_panels()
