extends TextureProgress

export var flash_scene : PackedScene
var last_gb

func _ready():
	G.GB_enabled = true
	
	value = G.GB
	max_value = G.GB_max
	last_gb = G.GB

func _process(delta):
	if G.GB != last_gb:
		var flash = flash_scene.instance() as GBFlash
		flash.set_value(G.GB - last_gb)
		flash.rect_global_position = Vector2(
			rect_size.x / 2.0,
			rect_size.y - (G.GB / float(G.GB_max))*rect_size.y
		)
		add_child(flash)
	last_gb = G.GB
	
	value = lerp(value, G.GB, 0.1)
	max_value = lerp(max_value, G.GB_max, 0.1)
