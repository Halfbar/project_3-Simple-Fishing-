extends CanvasLayer

@onready var fps_show_label: Label = $in_game/fps_show_label

func _process(_delta: float) -> void:
	fps_show_label.visible = SaveConfig.fps_show
	if SaveConfig.fps_show:
		fps_show_label.text = "FPS: " + str(Engine.get_frames_per_second())
