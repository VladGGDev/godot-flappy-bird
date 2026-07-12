class_name AutoStartParticles
extends GPUParticles2D

@export var is_one_shot := true


func _ready() -> void:
	if one_shot:
		one_shot = true
	emitting = true
