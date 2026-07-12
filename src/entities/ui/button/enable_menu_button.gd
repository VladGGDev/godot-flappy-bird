class_name EnableMenuButton
extends Button

@export var enable_on_ready: bool = false
@export var all_menus: Array[Control]
@export var enable_menu: Control
@export var fade_duration := 0.1

var processModes: Array[ProcessMode]


func _ready() -> void:
	assert(null not in all_menus, "all_menus contains null")
	var valid := false
	# Remember all normal process modes
	for c: Control in all_menus:
		processModes.append(c.process_mode)
		# Check if enable_menu is among all_menus
		if c == enable_menu:
			valid = true
	
	# Invalid exported data
	if not valid:
		push_error("enable_menu is not among all_menus")
		return
	
	pressed.connect(perform_enabling)
	if enable_on_ready:
		perform_enabling()


func perform_enabling() -> void:
	for c: Control in all_menus:
		set_enabled_control(c, c == enable_menu)


#func fade_menu(menu: Control, enable: bool) -> void:
	#if enable:
		#set_enabled_control(menu, true)
	#
	#var tween = create_tween()
	#tween.tween_property(menu, ^"modulate:a", enable as int, fade_duration)
	#if not enable:
		#tween.tween_callback(set_enabled_control.bind(menu, false))


func set_enabled_control(c: Control, enable: bool) -> void:
	c.visible = enable
	c.process_mode = processModes[all_menus.find(enable_menu)] if enable else Node.PROCESS_MODE_DISABLED
