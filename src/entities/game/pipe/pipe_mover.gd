class_name PipeMover
extends Node2D
## Simple script for moving a scene to the left.
## Stops all PipeMover scripts when touching anything.

static var are_all_moving := true

## Movement speed to the [b]left[/b]
@export var move_speed: float = 50


func _physics_process(delta: float) -> void:
	if not are_all_moving:
		return
	
	position.x -= move_speed * delta


func _on_alive_timer_timeout() -> void:
	queue_free()
