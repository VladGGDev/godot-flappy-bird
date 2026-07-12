extends CanvasLayer

@export var color_rect: ColorRect
@export var tween_duration := 0.1

var allow_pausing := true
var paused: bool:
	set(val):
		if allow_pausing:
			paused = val
			set_paused(val)


func _ready() -> void:
	paused = false
	visible = false
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		paused = !paused


func set_paused(value: bool) -> void:
	# Pause the tree
	get_tree().paused = value
	
	# Tween the modulate value
	if value:
		show()
	
	var tween = create_tween()
	tween.tween_property(
			color_rect, 
			^"modulate:a", 
			value as int, 
			tween_duration)
	if not value:
		tween.tween_callback(hide)


func _on_bird_started_game() -> void:
	allow_pausing = true


func _on_bird_ended_game() -> void:
	allow_pausing = false


func _on_resume_button_pressed() -> void:
	paused = false
