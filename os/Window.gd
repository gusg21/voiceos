tool

extends NinePatchRect

signal window_closed

export var window_name = "Asteroids" setget set_window_name, get_window_name
export var window_tex : Texture = null
export var window_auto_size : bool = true

const min_window_size = Vector2(124, 80)

var mouse_over = false
var dragging = false
var showing = false
var closing = false
var before_drag_mouse_position = Vector2.ZERO
var mouse_offset = Vector2.ZERO

func show_window():
	visible = true
	rect_scale.y = 0
	showing = true
	$Tween.interpolate_property(self, "rect_scale", Vector2(1, 0), Vector2(1, 1), 0.3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	
func close_window():
	closing = true
	$Tween.interpolate_property(self, "rect_scale", Vector2(1, 1), Vector2(0, 1), 0.3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()

func set_window_name(value):
	window_name = value
	compile_window()
	
func get_window_name():
	return window_name

func _ready():
	call_deferred("compile_window")
	
func compile_window():
	if window_auto_size and window_tex != null:
		rect_size = window_tex.get_size() + Vector2(18, 52)

	rect_pivot_offset = rect_size / 2
	
	if not has_node("Label") or not has_node("TextureRect"):
		return
	
	$Label.text = window_name
	$TextureRect.texture = window_tex

func _process(delta):
#	update()
	
	if showing or closing:
		return
	
	if mouse_over and Input.is_mouse_button_pressed(1) and not dragging and G.focused_window == null:
		dragging = true
		before_drag_mouse_position = get_global_mouse_position()
		mouse_offset = get_global_mouse_position() - rect_global_position
	elif dragging:
		G.focused_window = self
		rect_global_position = get_global_mouse_position() - mouse_offset
		dragging = Input.is_mouse_button_pressed(1)
		if not dragging:
			G.focused_window = null
		
	if dragging:
		if G.focusing_node != null:
			if G.focused_window == self and get_parent().name != "Focused":
				get_parent().remove_child(self)
				G.focusing_node.add_child(self)
			elif G.focused_window != self and get_parent().name == "Focused":
				get_parent().remove_child(self)
				G.window_container.add_child(self)
		

#func _on_HandlerArea_mouse_entered():
#	mouse_over = true
#
#func _on_HandlerArea_mouse_exited():
#	mouse_over = false

func _draw():
#	draw_string(G.get_font(), Vector2.ZERO, ("OVER" if mouse_over else "OFF") + " " + ("DRAG" if dragging else "NOT"))
	pass

func _on_Button_mouse_entered():
	mouse_over = true


func _on_Button_mouse_exited():
	mouse_over = false


func _on_Tween_tween_all_completed():
	if showing:
		showing = false
	if closing:
		closing = false
		queue_free()
		emit_signal("window_closed")
