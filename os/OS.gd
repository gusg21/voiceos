extends Node2D

class_name OS_

export var asteroids_scene : PackedScene
export var asteroids_position : Vector2
export var gbbar_scene : PackedScene
export var gbbar_position : Vector2
export var housing_scene : PackedScene
export var stocks_scene : PackedScene

export var end_scene : PackedScene

var layer_level = 0

func _ready():
	G.window_container = self
	G.os = self

func _enter_tree():
	call_deferred("show_main_menu")

func show_main_menu():
	$ControlPanel.show_window()

func pluck():
	var _pluck = $Pluck.duplicate()
	add_child(_pluck)
	_pluck.play()
	yield(_pluck, "finished")
	_pluck.queue_free()

func set_bg(bg):
	$Background.texture = bg

func fade_in(player):
	$Tween.interpolate_property(player, "volume_db", -80, 0, 1.0, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()

func add_audio_layer():
	layer_level += 1
	
	if layer_level == 1:
		for child in $AudioLayers.get_children():
			if child is AudioStreamPlayer:
				child.volume_db = -80
				child.play()
		fade_in($AudioLayers/MusicBody)
	if layer_level == 2:
		fade_in($AudioLayers/Snare)
		fade_in($AudioLayers/Kick)
	if layer_level == 3:
		fade_in($AudioLayers/Hats)
	if layer_level == 4:
		fade_in($AudioLayers/EB)
		fade_in($AudioLayers/Choir)
	
func begin_game():
	# show asteroids
	var asteroids = asteroids_scene.instance()
	asteroids.rect_global_position = asteroids_position
	asteroids.visible = false
	add_child(asteroids)
	asteroids.show_window()
	
	add_audio_layer()

	yield(get_tree().create_timer(30.0), "timeout")
#	yield(get_tree().create_timer(1.0), "timeout")
	
	var gbbar = gbbar_scene.instance()
	gbbar.rect_global_position = gbbar_position
	gbbar.visible = false
	add_child(gbbar)
	gbbar.show_window()
	
	add_audio_layer()
	
	yield(get_tree().create_timer(15.0), "timeout")
#	yield(get_tree().create_timer(1.0), "timeout")
	
	var housing = housing_scene.instance()
	housing.visible = false
	add_child(housing)
	housing.show_window()
	
	add_audio_layer()
	
	yield(get_tree().create_timer(25.0), "timeout")
	
	var stocks = stocks_scene.instance()
	stocks.visible = false
	add_child(stocks)
	stocks.show_window()
	
	add_audio_layer()

func _process(delta):
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()
	
	if G.GB >= G.GB_max:
		$NonPaused.end_game(end_scene)
