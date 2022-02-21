extends Node2D

var value = 1
var smooth_value = value
var done = false
var loading = false

func _ready():
	value = 1
	$Loading.value = 1
	$Fade.fade()
	$BootUpSound.play()
	
func inch():
	value += rand_range(0, 10.0)

func _process(delta):
	smooth_value = lerp(smooth_value, value, 0.1)
	$Loading.value = smooth_value
	
	if Input.is_action_just_pressed("ui_accept"):
		value = 100
	
	if $Loading.value >= 100.0 and not done:
		$Popup1.show_window()
		$Pluck.play()
		done = true

func _on_InchTimer_timeout():
	inch()
	$InchTimer.wait_time = rand_range(0.1, 1.5)


func _on_Fade_fade_complete():
	$InchTimer.start()
