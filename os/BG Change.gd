extends Label

var bgs = [
	preload("res://os/gfx/background.png"),
	preload("res://os/gfx/background2.png"),
	preload("res://os/gfx/background3.png"),
	preload("res://os/gfx/background4.png")
]
var bg = 0

func update_bg():
	if bg >= len(bgs):
		bg = 0
	if bg < 0:
		bg = len(bgs) - 1
	
	G.os.set_bg(bgs[bg])
	text = "BG " + str(bg + 1)

func _on_LeftButton_pressed():
	bg -= 1
	update_bg()

func _on_LeftButton2_pressed():
	bg += 1
	update_bg()
	
