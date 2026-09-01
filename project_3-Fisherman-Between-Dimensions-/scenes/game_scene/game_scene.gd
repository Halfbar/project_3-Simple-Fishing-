extends Node2D

@export var gs_bg_music: AudioStream

func _ready() -> void:
	SoundManager.stop_sounds()
	SoundManager.play_music(gs_bg_music)
