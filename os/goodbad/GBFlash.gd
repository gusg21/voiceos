extends Label

class_name GBFlash

var velocity = Vector2.ZERO

func set_value(v):
	text = ("+" if v >= 0 else "-") + str(max(abs(floor(v)), 1))
	add_color_override("font_color", (Color.green if v >= 0 else Color.red))
	if abs(v) > 5:
		rect_scale = Vector2(3, 3)

func _ready():
	velocity.y = -10
	velocity.x = rand_range(-10, 10)

func _process(delta):
	velocity.y += 0.5
	
	rect_global_position += velocity
	rect_rotation += 0.1
