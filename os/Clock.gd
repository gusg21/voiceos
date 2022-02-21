extends Label

func _process(delta):
	var time = OS.get_time()
	text = "%02d:%02d " % [time.hour % 12, time.minute] + ("PM" if time.hour >= 12 else "AM")
