extends Node2D

@export var radius := 8.0
@export_exp_easing("attenuation") var exponent := 2.0
@export var impulse := 100.0
@export var vertical_impulse := 25.0
@export var max_torque := 0.0

func _ready() -> void:
	#await get_tree().physics_frame
	
	for node in get_children():
		var rb := node as RigidBody2D
		if not rb:
			continue
		apply_explosion_force(rb)


func apply_explosion_force(rb: RigidBody2D) -> void:
	# Commented alternatives
	#var dir = position.direction_to(rb.position)
	var dir = (rb.position - position).normalized()
	#var dist = position.distance_to(rb.position)
	var dist = (rb.position - position).length()
	var mult = (max(0, radius - dist) / radius) ** exponent
	
	rb.apply_central_impulse(dir * impulse * mult)
	rb.apply_central_impulse(Vector2.UP * vertical_impulse * mult)
	rb.inertia = 1
	rb.apply_torque_impulse(randf_range(-max_torque, max_torque))
	
