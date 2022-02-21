extends Button

export var os_scene : PackedScene
export var window1_path : NodePath
export var window2_path : NodePath
onready var window1 = get_node(window1_path)
onready var window2 = get_node(window2_path)


func _on_Button2_pressed():
	window1.close_window()
	window2.close_window()
	
	yield(window1, "window_closed")
	
	get_tree().change_scene_to(os_scene)
