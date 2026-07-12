@tool
class_name PipeSpawner
extends Node2D

@export var pipe_scene: PackedScene
@export var timer: Timer

@export_group("Settings")
@export var draw_in_editor := true:
	set(val):
		draw_in_editor = val
		queue_redraw()
@export var max_height_variation := 100.0:
	set(val):
		max_height_variation = val
		queue_redraw()


func _on_timer_timeout() -> void:
	var instance := pipe_scene.instantiate() as Node2D
	random_height(instance)
	get_tree().current_scene.add_child(instance)


func random_height(node: Node2D) -> void:
	node.position = position
	node.position.y += randf_range(-max_height_variation, max_height_variation)


# Gizmos drawing
func _draw() -> void:
	if draw_in_editor and Engine.is_editor_hint():
		draw_line(Vector2(-50, -max_height_variation), Vector2(50, -max_height_variation), Color.ORANGE_RED)
		draw_line(Vector2(-50, max_height_variation), Vector2(50, max_height_variation), Color.ORANGE_RED)


func _on_bird_started_game() -> void:
	PipeMover.are_all_moving = true
	_on_timer_timeout()
	timer.start()


func _on_bird_ended_game() -> void:
	timer.stop()
	PipeMover.are_all_moving = false;
