class_name Bird
extends RigidBody2D

signal started_game
signal ended_game

@export var death_scene: PackedScene
@export var jump_height: float = 48.0
@export var flap_sound_player: AudioStreamPlayer

var pressed_jump := false
var started := false
#var death_scene_instance: Node2D


func _ready() -> void:
	ScoreManager.score = 0
	#death_scene_instance = death_scene.instantiate()
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("flap"):
		freeze = false
		pressed_jump = true
		flap_sound_player.play()
		if not started:
			started = true
			started_game.emit()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Integrating force is needed because apply_impulse will accumulate force when spamming
	if pressed_jump:
		pressed_jump = false
		var g = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_scale
		var jump_force = -sqrt(2.0 * g * jump_height)
		state.linear_velocity.y = jump_force


func _on_body_entered(_body: Node) -> void:
	ended_game.emit()
	if death_scene:
		var death_scene_instance = death_scene.instantiate()
		death_scene_instance.position = position
		get_tree().current_scene.add_child.call_deferred(death_scene_instance)
	queue_free()
