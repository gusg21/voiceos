extends Button

export var credits_window_path : NodePath
onready var credits_window = get_node(credits_window_path)
export var settings_window_path : NodePath
onready var settings_window = get_node(settings_window_path)

func _on_PlayButton_pressed():
	G.os.pluck()
	
	get_parent().close_window()
	if credits_window.visible:
		credits_window.close_window()
	if settings_window.visible:
		settings_window.close_window()
	
	yield(get_parent(), "window_closed")
	
	G.os.begin_game()

func _on_QuitButton_pressed():
	G.os.pluck()
	
	get_parent().close_window()
	yield(get_parent(), "window_closed")
	get_tree().quit()

func _on_CreditsButton_pressed():
	G.os.pluck()
	
	if not credits_window.visible:
		credits_window.show_window()

func _on_SettingsButton_pressed():
	G.os.pluck()
	
	if not settings_window.visible:
		settings_window.show_window()
