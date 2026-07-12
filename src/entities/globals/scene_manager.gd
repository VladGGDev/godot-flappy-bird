extends Node

signal scene_changed(scene_root: Node)
signal scene_added(scene_root: Node)

## The path from the [member Window.current_scene] to the AdditiveScenes node
const ADDITIVE_SCENE_REL_PATH := ^"AdditiveScenes"

## Changes the current scene to [param scene] or reloads the scene if empty.
## Also returns its root node.
## [br]Calling this function also removes all additive scenes 
## that are children of the current scene.
func change_scene(scene_path: String = "") -> Node:
	get_tree().paused = false
	if not scene_path:
		scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(scene_path)
	await get_tree().scene_changed
	scene_changed.emit(get_tree().current_scene)
	return get_tree().current_scene


## Changes the current scene to [param scene] or reloads the scene if empty
## with a short fade to black. Also returns its root node.
## [br]Calling this function also removes all additive scenes 
## that are children of the current scene.
func change_scene_with_transition(scene_path: String = "", fade_duration: float = 0.5) -> Node:
	await Crossfade.fade_in(fade_duration)
	var instance := await change_scene(scene_path)
	await Crossfade.fade_out(fade_duration)
	return instance


## Adds [param scene] to the current scene at a relative path 
## (see [constant ADDITIVE_SCENE_REL_PATH]) or, 
## if [param absolute] is [code]true[/code], at the root level. 
## [br]Also returns the root node of [param scene].
func add_scene(scene_path: String, absolute: bool = false, readable_name: bool = true) -> Node:
	var scene := load(scene_path) as PackedScene
	var instance := scene.instantiate()
	if not absolute:
		# Create the additive scene node if it doesn't exist
		if not get_tree().current_scene.has_node(ADDITIVE_SCENE_REL_PATH):
			var node := Node.new()
			get_tree().current_scene.add_child(node)
			node.name = StringName(ADDITIVE_SCENE_REL_PATH)
		get_tree().current_scene.get_node(ADDITIVE_SCENE_REL_PATH).add_child(instance, readable_name)
	else:
		get_tree().root.add_child(instance, readable_name)
	
	scene_added.emit(instance)
	return instance


## Returns all additive scenes that are children of the current scene 
## additive scene node (see [constant ADDITIVE_SCENE_REL_PATH]).
## [br][br][b]Does not return additive scenes with [code]absolute[/code]
## set to [code]true[/code]![/b]
func get_all_additive_scenes() -> Array[Node]:
	var scenes := get_tree().current_scene.get_node_or_null(ADDITIVE_SCENE_REL_PATH)
	if not scenes:
		return []
	return scenes.get_children()
