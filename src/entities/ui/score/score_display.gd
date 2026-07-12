extends Label

## Show the highscore instead of score
@export var show_high_score: bool


func _ready() -> void:
	update_score()
	ScoreManager.score_changed.connect(update_score)


func update_score() -> void:
	var val = ScoreManager.score if not show_high_score else ScoreManager.high_score
	text = str(val)
