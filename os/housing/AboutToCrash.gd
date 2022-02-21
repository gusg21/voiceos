extends Sprite

var my_visible = false

func _process(delta):
	modulate = Color(1, 1, 1, 1) if my_visible else Color(1, 1, 1, 0)

func _on_Timer_timeout():
	my_visible = not my_visible
	
