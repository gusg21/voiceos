extends "res://os/Window.gd"

export(String, MULTILINE) var contents = ""
export(String) var button_label = ""

func _ready():
	._ready()
	
	$Label.text = "Help!"
	$Exit.text = button_label
	$Help.text = contents
	
