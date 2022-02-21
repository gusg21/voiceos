extends Control

func _on_MusicCheckButton_toggled(button_pressed):
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_bus, not button_pressed)
	
func _on_SFXCheckButton_toggled(button_pressed):
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx_bus, not button_pressed)
	
	G.os.pluck()
	
