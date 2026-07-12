@tool
class_name RandomPipeDistance
extends Node2D

@export_group("Settings")
@export var draw_in_editor := true:
	set(val):
		draw_in_editor = val
		queue_redraw()
@export var min_distance := 30.0:
	set(val):
		min_distance = val
		queue_redraw()
@export var max_distance := 40.0:
	set(val):
		max_distance = val
		queue_redraw()

@export_group("Nodes")
@export var top_pipe: Node2D
@export var bottom_pipe: Node2D
@export var scoring_area_shape: CollisionShape2D


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	# Setup pipe distance
	var dist = randf_range(min_distance, max_distance)
	
	top_pipe.position.y = -dist
	bottom_pipe.position.y = dist
	
	var shape = SegmentShape2D.new()
	shape.a.y = -dist
	shape.b.y = dist
	scoring_area_shape.shape = shape


# Drawing gizmos
func _draw() -> void:
	if draw_in_editor and Engine.is_editor_hint():
		const START = -50
		const END = -START
		draw_line(Vector2(START, min_distance), Vector2(END, min_distance), Color.RED)
		draw_line(Vector2(START, -min_distance), Vector2(END, -min_distance), Color.RED)
		draw_line(Vector2(START, max_distance), Vector2(END, max_distance), Color.RED)
		draw_line(Vector2(START, -max_distance), Vector2(END, -max_distance), Color.RED)
