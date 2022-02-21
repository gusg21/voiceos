extends Node

var GB = 10
var GB_max = 250
var GB_enabled = false
var housing_income = 0
var about_to_crash = false

var os : OS_ = null

var focused_window = null
var focusing_node = null
var window_container = null

func get_font():
	return Label.new().get_font("")
