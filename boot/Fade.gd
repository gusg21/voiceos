extends Sprite

export var show_on_ready = true

signal fade_complete

func _ready():
	if show_on_ready:
		visible = true

func fade():
	visible = true
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.0, Tween.TRANS_LINEAR)
	$Tween.start()

func fade_out():
	modulate.a = 0
	visible = true
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 3.0, Tween.TRANS_LINEAR)
	$Tween.start()

func _on_Tween_tween_all_completed():
	emit_signal("fade_complete")
