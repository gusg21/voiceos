extends Sprite

export var explosion_scene : PackedScene = null
var velocity = Vector2.ZERO

func _ready():
	rotation = rand_range(0, TAU)

func set_velocity(velocity):
	self.velocity = velocity

func _process(delta):
	position += velocity
	rotation += 0.1
	
	if global_position.distance_to(Vector2.ZERO) > 2000:
		queue_free()

func _on_Area2D_area_entered(area : Area2D):
	if area.is_in_group("bullet"):
		var explosion = explosion_scene.instance()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
		area.get_parent().queue_free()
		
		if G.GB_enabled:
			G.GB += 1
		
	if area.is_in_group("player"):
		var explosion = explosion_scene.instance()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		area.get_parent().linear_velocity = velocity
		queue_free()
