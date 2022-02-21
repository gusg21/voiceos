extends Sprite

var velocity

func _ready():
	$CPUParticles2D.emitting = true

func set_velocity(velocity):
	self.velocity = velocity

func _process(delta):
	rotation += 1
	
	position += velocity
	
	if global_position.distance_to(Vector2.ZERO) > 2000:
		queue_free()
