class_name ExitGameButton
extends Button

@export var fade_duration := 0.5


func _ready() -> void:
	pressed.connect(exit_game)


func exit_game() -> void:
	await Crossfade.fade_in(fade_duration)
	SaveManager.quit()
