extends CanvasLayer

@onready var fps_show_label: Label = $in_game/fps_show_label
@onready var fish_collection: Control = $event_ui/event_ui_boundaries/fish_collection
@onready var event_ui_boundaries: Control = $event_ui/event_ui_boundaries
@onready var stamina_bar: ProgressBar = $in_game/stamina_bar

func _ready() -> void:
	SignalBus.event_started.connect(_on_event_started)
	close_panels()
	await get_tree().process_frame
	stamina_bar.max_value = GameManager.fishing_rod.max_stamina

func _on_event_started(_fish_behavior: FishResource):
	close_panels()
	return
	# show ui

func _process(_delta: float) -> void:
	fps_show_label.visible = SaveConfig.fps_show
	if SaveConfig.fps_show:
		fps_show_label.text = "FPS: " + str(Engine.get_frames_per_second())
	var stamina := GameManager.fishing_rod.stamina
	stamina_bar.value = stamina
	stamina_bar.visible = stamina < GameManager.fishing_rod.max_stamina

func close_panels():
	var childs = event_ui_boundaries.get_children()
	for child in childs:
		child.visible = false
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_open_collection_btn_pressed() -> void:
	fish_collection.visible = true
	fish_collection.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_close_collection_btn_pressed() -> void:
	fish_collection.visible = false
	fish_collection.mouse_filter = Control.MOUSE_FILTER_IGNORE
