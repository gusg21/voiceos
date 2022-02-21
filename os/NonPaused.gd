extends Node2D

export var fade_path : NodePath
onready var fade = get_node(fade_path)

func end_game(end_scene):
	get_tree().paused = true
	fade.fade_out()
	yield(fade, "fade_complete")
	get_tree().paused = false
	get_tree().change_scene_to(end_scene)
