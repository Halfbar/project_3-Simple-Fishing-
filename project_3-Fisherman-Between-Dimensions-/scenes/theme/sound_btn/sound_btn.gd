extends Button
class_name SoundButton

@export var hover_sound: AudioStream
@export var press_sound: Array[AudioStream]

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	if hover_sound:
		SoundManager.play_sound(hover_sound, "SFX", true)
	create_tween().tween_property(self, "scale", Vector2(1.05,1.05), 0.1)

func _on_mouse_exited():
	create_tween().tween_property(self, "scale", Vector2.ONE, 0.1)

func _on_pressed() -> void:
	if !press_sound.is_empty():
		var selected_sound = press_sound.pick_random()
		SoundManager.play_sound(selected_sound, "SFX")
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(0.92,0.92),0.05)
	t.tween_property(self,"scale",Vector2(1.08,1.08),0.07)
	t.tween_property(self,"scale",Vector2.ONE,0.07)
