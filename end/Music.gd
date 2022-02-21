extends AudioStreamPlayer

func _ready():
	volume_db = -80
	play()
	$Tween.interpolate_property(self, "volume_db", -80, 0, 2.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
