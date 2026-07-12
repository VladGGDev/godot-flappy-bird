extends Node
## Contains members managing the current score and highscore

## Called anytime [member score] is set to
signal score_changed

var score: int = 0:
	set(val):
		if val > high_score:
			high_score = val
		score = val
		score_changed.emit()
var high_score: int = 0


func _ready() -> void:
	SaveManager.get_save_data.connect(func(data): 
		high_score = data.get("highscore", 0)
	)
	SaveManager.set_save_data.connect(func(data): 
		data["highscore"] = high_score
	)
