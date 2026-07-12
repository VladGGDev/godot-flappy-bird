extends Node

signal get_save_data(data: Dictionary)
signal set_save_data(data: Dictionary)

var save_path := "user://save.data"
var data_ready := false
var data := {}


func _ready() -> void:
	get_tree().auto_accept_quit = false
	load_file.call_deferred()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		quit()


func quit() -> void:
	save_file()
	get_tree().quit()


func save_file() -> void:
	set_save_data.emit(data)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "  "))
	

func load_file() -> void:
	#var file = FileAccess.open(save_path, FileAccess.READ)
	if not FileAccess.file_exists(save_path):
		data = {}
		return
	data = JSON.parse_string(FileAccess.get_file_as_string(save_path))
	data_ready = true
	get_save_data.emit(data)


func delete_save_file() -> void:
	DirAccess.remove_absolute(save_path)
