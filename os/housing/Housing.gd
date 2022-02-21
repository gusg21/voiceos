extends Node2D

var computes_since_crash = 0
var goodbad_scaling = 1/50.0
var value_crossover = 30

func _ready():
	for child in $Blocks.get_children():
		var block = child as Block
		block.set_value(rand_range(0, 100))
	
	recompute()

func recompute():
	computes_since_crash += 1
	
	if not G.about_to_crash and computes_since_crash > 7:
		if randf() < 0.25:
			G.about_to_crash = true
			$Abouttocrash.visible = true
			$Alarm.play()
			
	elif G.about_to_crash:
		$Abouttocrash.visible = false
		G.about_to_crash = false
		computes_since_crash = 0
		for child in $Blocks.get_children():
			var block = child as Block
			block.set_value(rand_range(0, 10))
		G.GB += G.housing_income * goodbad_scaling
		return
	
	for child in $Blocks.get_children():
		if randf() > 0.25:
			var sum = 0
			for neighbor in child.neighbors:
				sum += neighbor.value
			child.set_value(lerp(child.value, sum / len(child.neighbors), 0.1))
		else:
			child.set_value(rand_range(0, 100))
		
		
	G.GB += G.housing_income * goodbad_scaling

func refresh_income():
	var income = (-50 if G.about_to_crash else 0)
	for child in $Blocks.get_children():
		if child.owned:
			income += child.value + -value_crossover
		
	G.housing_income = income
	$Money/Label.text = "$" + str(floor(G.housing_income)) + "/s"

func _on_Timer_timeout():
	recompute()

func _on_DisplayUpdate_timeout():
	refresh_income()
