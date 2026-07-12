class_name UISoundPlayer
extends AudioStreamPlayer

@export var node: Node
@export var signal_names: Array[StringName]


func _ready() -> void:
	for sgn_name in signal_names:
		if not node.get_signal_list().any(func(s): return sgn_name == s["name"]):
			push_error("No signal named %s on %s" % [sgn_name, node])
			return
		var signal_ref = Signal(node, sgn_name)
		signal_ref.connect(make_sound)


func make_sound() -> void:
	play()
