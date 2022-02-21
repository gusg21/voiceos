extends AnimatedSprite

class_name Block

var neighbors = []
var value = 0
var owned = false
var last_frame_mouse = false

var mouse_over = false

func _ready():
	for block in get_parent().get_children():
		if global_position.distance_to(global_position) < 26:
			neighbors.append(block)
	
	$Owned.visible = owned

func _process(delta):
	$Owned.visible = owned
	
	mouse_over = Rect2(global_position, Vector2(100, 100)).has_point(get_global_mouse_position())
	scale = Vector2(1.1, 1.1) if mouse_over and not Input.is_mouse_button_pressed(BUTTON_LEFT) else Vector2(1, 1)
	z_index = 10 if mouse_over and not Input.is_mouse_button_pressed(BUTTON_LEFT) else 0
	offset = Vector2(-1, -1) if mouse_over and not Input.is_mouse_button_pressed(BUTTON_LEFT) else Vector2(0, 0)
	
	$Owned.scale = scale
	$Owned.z_index = z_index
	$Owned.offset = offset
	
	if mouse_over and Input.is_mouse_button_pressed(BUTTON_LEFT) and not last_frame_mouse:
		if owned:
			owned = false
		else:
			owned = true
	last_frame_mouse = Input.is_mouse_button_pressed(BUTTON_LEFT)
	
	update()

func _draw():
#	draw_string(G.get_font(), Vector2(0, 10), str(floor(value)))
	pass

func set_value(value):
	if value > 66:
		frame = 0
	elif value > 33:
		frame = 1
	else:
		frame = 2

	self.value = value
	
