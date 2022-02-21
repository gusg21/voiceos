extends Node2D

export var wildness = 1.0
export var num_stocks = 16
export var max_value = 100

var stocks_owned = 0

var points = []
var colors = []
var count = 40

var acceleration = rand_range(-1, 1)
var velocity = rand_range(-1, 1) 
var _position = rand_range(-1, 1)

func _ready():
	randomize()
	
	for i in count:
		refresh()

	update_line()

func add_datum(datum):
	points.push_front(datum)
	points.resize(count)
	colors.push_front(lerp(Color.red, Color.green, datum / 100.0))
	colors.resize(count)
	update_line()

func update_line():
	var j = 0.0
	$Line.clear_points()
	for i in points:
		if i == null:
			continue
		
		var pt = Vector2(
			135 - (j * 135/(count-1)), 40 - (i * (2/5.0))
		)
		$Line.add_point(pt)
		j += 1.0
	
	var gradient = Gradient.new()
	j = 0.0
	for color in colors:
		if color == null:
			continue
		
		gradient.add_point(j / count, color)
		j += 1.0
	$Line.gradient = gradient

func refresh():
	acceleration = rand_range(-1, 1)
	if _position > 90:
		acceleration = rand_range(-1, 0)
	if _position < 10:
		acceleration = rand_range(0, 1)
	velocity += acceleration + rand_range(-3 * wildness, 3 * wildness)
	velocity = clamp(velocity, -5, 5)
	if G.about_to_crash:
		velocity = rand_range(-5, -15)
	_position += velocity + rand_range(-10, 10)
	_position = clamp(_position, 0, 100)
	add_datum(_position)
	
	$Value.text = "Value:\n" + str(floor(_position * (max_value / 100.0))) + "/" + str(max_value)

func get_money():
	return G.GB * 10

func take_money(money):
	G.GB -= money / 10.0

func add_money(money):
	G.GB += money / 10.0

func _process(delta):
	$BuyButton.disabled = get_money() < _position or stocks_owned >= num_stocks 
	$SellButton.disabled = stocks_owned < 1
	
	$Owned.text = "Owned:\n" + str(stocks_owned) + "/" + str(num_stocks)

func _on_RefreshTimer_timeout():
	refresh()

func _on_BuyButton_pressed():
	if get_money() > _position * (max_value / 100.0) and stocks_owned < num_stocks:
		take_money(_position * (max_value / 100.0))
		stocks_owned += 1
		_position += 1

func _on_SellButton_pressed():
	if stocks_owned > 0:
		stocks_owned -= 1
		add_money(_position * (max_value / 100.0))
		_position -= 1
