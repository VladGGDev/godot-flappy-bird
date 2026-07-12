extends Area2D

@export var stream_player: AudioStreamPlayer


func _on_body_exited(_body: Node2D) -> void:
	# Increase score and play a sound
	ScoreManager.score += 1
	stream_player.play()
