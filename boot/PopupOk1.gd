extends Button

export var next_window_path : NodePath
onready var next_window = get_node(next_window_path)

func _on_Button2_pressed():
	$Pluck.play()
	next_window.show_window()
