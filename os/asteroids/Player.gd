extends Node2D

export var bullet_scene : PackedScene

var speed = 0
var _rotation = 0
var linear_velocity : Vector2

var max_speed = 7
var move_speed = 0.2
var bullet_offset = Vector2(0, -50)

func _process(delta):
#	update()
	
	if Input.is_action_pressed("ui_up"):
		linear_velocity += Vector2.RIGHT.rotated(_rotation - PI/2).normalized() * move_speed
	if Input.is_action_pressed("ui_down"):
		linear_velocity -= Vector2.RIGHT.rotated(_rotation - PI/2).normalized() * move_speed
		
	if Input.is_action_pressed("ui_left"):
		_rotation -= 0.1
	if Input.is_action_pressed("ui_right"):
		_rotation += 0.1
	
	linear_velocity = linear_velocity.clamped(max_speed)
	linear_velocity = linear_velocity.linear_interpolate(Vector2.ZERO, 0.01)
	
	$GFX.rotation = lerp($GFX.rotation, _rotation, 0.2)
	position += linear_velocity
	
	if Input.is_action_just_pressed("ui_accept"):
		var bullet = bullet_scene.instance()
		bullet.global_position = global_position + bullet_offset.rotated($GFX.rotation)
		bullet.set_velocity(Vector2.RIGHT.rotated(_rotation - PI/2).normalized() * 30)
		get_parent().add_child(bullet)
	
	if position.x < -50:
		position.x = 650
	if position.x > 650:
		position.x = -50
	if position.y < -50:
		position.y = 650
	if position.y > 650:
		position.y = -50

func _draw():#	draw_string(G.get_font(), Vector2.ZERO, str(speed))
#	draw_string(G.get_font(), Vector2(0, 20), str(_rotation))
	pass
