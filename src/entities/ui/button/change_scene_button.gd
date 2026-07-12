class_name ChangeSceneButton
extends Button

@export_file("*.tscn", "*.scn") var scene_path: String
@export var fade_duration := 0.5


func _ready() -> void:
	pressed.connect(switch_scene)


func switch_scene() -> void:
	SceneManager.change_scene_with_transition(scene_path)
