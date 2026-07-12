extends CanvasLayer
## Singleton used for fading in and out to a fullscreen color 
## over an amount of time. [br][br]
##
## Use [signal finish_fade_to_color], [signal finish_fade_in], [signal finish_fade_out] along with
## [code]await[/code] for more functionality.

signal finish_fade_to_color(color: Color)
signal finish_fade_in
signal finish_fade_out

@onready var color_rect: ColorRect = $ColorRect


## Fade a fullscreen [ColorRect] to [param color] over [param duration] time.
func fade_to_color(duration: float, color: Color) -> void:
	var tween = create_tween().set_ignore_time_scale()
	tween.tween_property(color_rect, "color", color, duration)
	await tween.finished
	finish_fade_to_color.emit(color)


## Fade to [constant Color.BLACK] over [param duration] time.
func fade_in(duration: float) -> void:
	await fade_to_color(duration, Color.BLACK)
	finish_fade_in.emit()


## Fade to [constant Color.TRANSPARENT] over [param duration] time.
func fade_out(duration: float) -> void:
	await fade_to_color(duration, Color(color_rect.color, 0))
	finish_fade_out.emit()


## Fade in to black and out to transparent.[br]
## The fade in duration is [param duration_in], the fade out duration is
## [param duration_out]. Set [param duration_out] to less than 0 to use
## [param duration_in] value for both fading in and out.
func fade_in_and_out(duration_in: float, duration_out: float = -1):
	await fade_in(duration_in)
	await fade_out(duration_out if duration_out >= 0 else duration_in)
