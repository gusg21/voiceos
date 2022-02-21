extends Sprite

func _process(delta):
	position.x -= 3
	rotation -= 0.1
	
	if position.x < -20:
		position.x = 2030
