extends CanvasLayer

@onready var fps_show_label: Label = $in_game/fps_show_label

func _ready() -> void:
	SignalBus.event_started.connect(_on_event_started)

func _on_event_started(_fish_behavior: FishResource):
	return
	# show ui

func _process(_delta: float) -> void:
	fps_show_label.visible = SaveConfig.fps_show
	if SaveConfig.fps_show:
		fps_show_label.text = "FPS: " + str(Engine.get_frames_per_second())
