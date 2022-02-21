tool

extends Node2D

export var enemy_scene : PackedScene
export var direction : float setget set_direction, get_direction
export var spread : float = 1
export var speed : float = 30
export var spawn_time : float = 5
export var spawn_time_dev : float = 1

func _ready():
	$Timer.wait_time = spawn_time

func set_direction(value):
	direction = value
	update()

func get_direction():
	return direction

func spawn_enemy():
	var enemy = enemy_scene.instance()
	enemy.position = position
	enemy.set_velocity(Vector2.RIGHT.rotated(direction + rand_range(-spread, spread)) * speed)
	get_parent().add_child(enemy)
	
func _on_Timer_timeout():
	spawn_enemy()
	$Timer.wait_time = spawn_time + rand_range(-spawn_time_dev, spawn_time_dev)
