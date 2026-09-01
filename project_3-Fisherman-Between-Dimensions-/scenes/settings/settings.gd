extends Control

# Audio Tab --------------------------------------------------
@onready var master_slider: HSlider = $divider_vbox/control_panel/tab_margin/tab_container/sound_tab/sound_hcontainer/master_config/master_margin/master_hbox/master_slider
@onready var music_slider: HSlider = $divider_vbox/control_panel/tab_margin/tab_container/sound_tab/sound_hcontainer/music_config/music_margin/music_hbox/music_slider
@onready var sfx_slider: HSlider = $divider_vbox/control_panel/tab_margin/tab_container/sound_tab/sound_hcontainer/sfx_config/sfx_margin/sfx_hbox/sfx_slider
# Audio Tab --------------------------------------------------

@onready var window_mode_options: OptionButton = $divider_vbox/control_panel/tab_margin/tab_container/screen_tab/VBoxContainer/window_mode_hbox/window_mode_options
@onready var window_size_options: OptionButton = $divider_vbox/control_panel/tab_margin/tab_container/screen_tab/VBoxContainer/window_size_hbox/window_size_options
@onready var fps_limiter_options: OptionButton = $divider_vbox/control_panel/tab_margin/tab_container/screen_tab/VBoxContainer/fps_limiter_hbox/fps_limiter_options
@onready var vsync_check: CheckBox = $divider_vbox/control_panel/tab_margin/tab_container/screen_tab/VBoxContainer/other_hbox/MarginContainer/other_hbox/vsync_check
@onready var fps_show_check: CheckBox = $divider_vbox/control_panel/tab_margin/tab_container/screen_tab/VBoxContainer/other_hbox/MarginContainer/other_hbox/fps_show_check

@onready var tab_container: TabContainer = $divider_vbox/control_panel/tab_margin/tab_container

func _ready() -> void:
	load_audio_settings()
	load_screen_settings()
	
func config_file_save():
	SaveConfig.save_settings()
	SaveConfig.apply_settings()

func load_audio_settings():
	master_slider.value = SaveConfig.master_volume
	sfx_slider.value = SaveConfig.sfx_volume
	music_slider.value = SaveConfig.music_volume

func load_screen_settings():
	vsync_check.button_pressed = SaveConfig.vsync
	fps_show_check.button_pressed = SaveConfig.fps_show
	window_mode_options.selected = SaveConfig.window_mode
	
	match SaveConfig.window_size:
		Vector2i(1280, 720):
			window_size_options.selected = 0
		Vector2i(1600, 900):
			window_size_options.selected = 1
		Vector2i(1920, 1080):
			window_size_options.selected = 2
		Vector2i(2560, 1440):
			window_size_options.selected = 3
	
	match SaveConfig.max_fps:
		30:
			fps_limiter_options.selected = 0
		60:
			fps_limiter_options.selected = 1
		120:
			fps_limiter_options.selected = 2
		0:
			fps_limiter_options.selected = 3

# Audio Tab --------------------------------------------------
func _on_master_slider_value_changed(value: float) -> void:
	SaveConfig.master_volume = value
	config_file_save()


func _on_music_slider_value_changed(value: float) -> void:
	SaveConfig.music_volume = value
	config_file_save()


func _on_sfx_slider_value_changed(value: float) -> void:
	SaveConfig.sfx_volume = value
	config_file_save()
# Audio Tab --------------------------------------------------

# Tab Buttons --------------------------------------------------
func _on_btn_sound_pressed() -> void:
	tab_container.current_tab = 0


func _on_btn_screen_pressed() -> void:
	tab_container.current_tab = 1


func _on_btn_controls_pressed() -> void:
	tab_container.current_tab = 2
# Tab Buttons --------------------------------------------------

# Screen Tab ---------------------------------------------------
func _on_window_mode_options_item_selected(index: int) -> void:
	SaveConfig.window_mode = index
	config_file_save()

func _on_window_size_options_item_selected(mode: int):
	match mode:
		0:
			SaveConfig.resolution = Vector2i(1280, 720)
		1:
			SaveConfig.resolution = Vector2i(1600,900)
		2:
			SaveConfig.resolution = Vector2i(1920,1080)
		3:
			SaveConfig.resolution = Vector2i(2560,1440)
	config_file_save()

func _on_fps_limiter_options_item_selected(mode: int):
	match mode:
		0:
			SaveConfig.max_fps = 30
		1:
			SaveConfig.max_fps = 60
		2:
			SaveConfig.max_fps = 120
		3:
			SaveConfig.max_fps = 0
	config_file_save()

func _on_vsync_check_pressed() -> void:
	SaveConfig.vsync = vsync_check.button_pressed
	config_file_save()

func _on_fps_show_check_pressed() -> void:
	SaveConfig.fps_show = fps_show_check.button_pressed
	config_file_save()
# Screen Tab ---------------------------------------------------
