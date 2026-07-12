extends MarginContainer

@export var sound_slider: Slider
@export var music_slider: Slider
#@export var fullscreen_button: Button
#@export var clear_save_button: Button

var fullscreen := false


func _ready() -> void:
	SaveManager.get_save_data.connect(get_save_data)
	SaveManager.set_save_data.connect(set_save_data)
	if SaveManager.data_ready:
		get_save_data(SaveManager.data)


func set_save_data(data: Dictionary) -> void:
	data["sound"] = sound_slider.value
	data["music"] = music_slider.value
	data["fullscreen"] = fullscreen


func get_save_data(data: Dictionary) -> void:
	sound_slider.value = data.get("sound", sound_slider.value) as float
	music_slider.value = data.get("music", music_slider.value) as float
	fullscreen = data.get("fullscreen", false) as bool
	handle_fullscreen_change()
	handle_sound_change()


func handle_sound_change() -> void:
	var music_bus_idx = AudioServer.get_bus_index("Music")
	var sound_bus_idx = AudioServer.get_bus_index("Sounds")
	AudioServer.set_bus_volume_linear(music_bus_idx, music_slider.value)
	AudioServer.set_bus_volume_linear(sound_bus_idx, sound_slider.value)


func handle_fullscreen_change() -> void:
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)


func _on_sound_slider_value_changed(_value: float) -> void:
	handle_sound_change()
	set_save_data(SaveManager.data)


func _on_music_slider_value_changed(_value: float) -> void:
	handle_sound_change()
	set_save_data(SaveManager.data)


func _on_fullscreen_button_pressed() -> void:
	fullscreen = !fullscreen
	handle_fullscreen_change()
	set_save_data(SaveManager.data)


func _on_clear_save_button_pressed() -> void:
	SaveManager.delete_save_file()
