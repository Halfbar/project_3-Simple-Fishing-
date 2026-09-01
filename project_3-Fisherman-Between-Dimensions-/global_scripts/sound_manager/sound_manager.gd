extends Node

@onready var audio_players: Array[AudioStreamPlayer]
@onready var music_player: AudioStreamPlayer = $music_player

func _ready():
	audio_players = [
		$sfx_players/sfx_player, $sfx_players/sfx_player2, 
		$sfx_players/sfx_player3, $sfx_players/sfx_player4, 
		$sfx_players/sfx_player5, $sfx_players/sfx_player6, 
		$sfx_players/sfx_player7, $sfx_players/sfx_player8, 
		$sfx_players/sfx_player9, $sfx_players/sfx_player10, 
		$sfx_players/sfx_player11, $sfx_players/sfx_player12, 
		$sfx_players/sfx_player13, $sfx_players/sfx_player14, 
		$sfx_players/sfx_player15, $sfx_players/sfx_player16, 
		$sfx_players/sfx_player17, $sfx_players/sfx_player18, 
		$sfx_players/sfx_player19, $sfx_players/sfx_player20
	]

func play_sound(sound_stream: AudioStream,  bus_name: String = "Master", random_pitch: bool = false, fade_out: bool = false):
	for p in audio_players:
		if not p.playing:
			p.bus = bus_name
			p.stream = sound_stream
			if random_pitch:
				p.pitch_scale = randf_range(0.9, 1.1)
			else:
				p.pitch_scale = 1.0
			p.play()
			if fade_out:
				var tween = create_tween()
				tween.tween_interval(2)
				tween.tween_property(p, "volume_db", -40.0, 1.0)
				tween.tween_callback(p.stop)
				tween.tween_callback(func(): p.volume_db = -15.0)
			return

func play_music(music):
	music_player.stream = music
	music_player.play()

func stop_sounds():
	for player in audio_players:
		player.stop()
	music_player.stop()
