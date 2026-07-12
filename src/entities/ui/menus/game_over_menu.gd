extends CanvasLayer

@export var color_rect: ColorRect
@export var tween_wait := 0.5
@export var tween_duration := 0.2


func _ready() -> void:
	hide()


func _on_bird_ended_game() -> void:
	color_rect.modulate.a = 0
	var tween = create_tween()
	tween.tween_interval(tween_wait)
	tween.tween_callback(show)
	tween.tween_property(
			color_rect, 
			^"modulate:a", 
			1, 
			tween_duration)


func _on_retry_button_pressed() -> void:
	SceneManager.change_scene_with_transition()
