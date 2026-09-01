extends Node

const SAVE_PATH = "user://settings.cfg"

# Audio ------------------------------------------------
var master_volume: float = 1.0
var sfx_volume: float = 1.0
var music_volume: float = 1.0
# Audio ------------------------------------------------

# Display ------------------------------------------------
var window_mode: int = 0
var window_size: Vector2i = Vector2i(1280, 720)
var vsync: bool = true
var max_fps: int = 60
var fps_show: bool = false
# Display ------------------------------------------------

func _ready():
	load_settings()
	apply_settings()
	
func save_settings():
	var config = ConfigFile.new()
	
	# Audio ------------------------------------------------
	config.set_value("audio","master",master_volume)
	config.set_value("audio","sfx",sfx_volume)
	config.set_value("audio","music",music_volume)
	# Audio ------------------------------------------------
	
	# Display ------------------------------------------------
	config.set_value("display", "window_mode", window_mode)
	config.set_value("display", "window_size", window_size)
	config.set_value("display", "vsync", vsync)
	config.set_value("display", "max_fps", max_fps)
	config.set_value("display", "fps_show", fps_show)
	# Display ------------------------------------------------
	
	config.save(SAVE_PATH)

func load_settings():

	var config = ConfigFile.new()
	
	if config.load(SAVE_PATH) != OK:
		save_settings()
		return
	# Audio ------------------------------------------------
	master_volume = config.get_value("audio","master",1.0)
	sfx_volume = config.get_value("audio","sfx",1.0)
	music_volume = config.get_value("audio","music",1.0)
	# Audio ------------------------------------------------
	
	# Display ------------------------------------------------
	window_mode = config.get_value("display", "window_mode", 0)
	window_size = config.get_value("display", "window_size", Vector2i(1280, 720))
	vsync = config.get_value("display", "vsync", true)
	max_fps = config.get_value("display", "max_fps", 60)
	fps_show = config.get_value("display", "fps_show", false)
	# Display ------------------------------------------------

func apply_settings():
	apply_audio_settings()
	apply_display_settings()

# Audio ------------------------------------------------
func apply_audio_settings():
	set_bus("Master", master_volume)
	set_bus("SFX", sfx_volume)
	set_bus("Music", music_volume)

func set_bus(bus:String,value:float):
	var index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(index,linear_to_db(value))
# Audio ------------------------------------------------

# Display ------------------------------------------------
func apply_display_settings():
	set_window_mode(window_mode)
	set_resolution(window_size)
	set_vsync(vsync)
	set_fps_limit(max_fps)
	set_show_fps(fps_show)

func set_window_mode(mode: int):
	match mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func set_resolution(value: Vector2i):
	DisplayServer.window_set_size(value)

func set_vsync(enabled: bool):
	if enabled:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func set_fps_limit(value: int):
	Engine.max_fps = value

func set_show_fps(value: bool):
	fps_show = value
# Display ------------------------------------------------
